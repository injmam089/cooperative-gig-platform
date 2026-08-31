package com.sih.workerreg.service;

import com.sih.workerreg.model.Customer;
import com.sih.workerreg.model.OtpVerification;
import com.sih.workerreg.repository.CustomerRepository;
import com.sih.workerreg.repository.OtpVerificationRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class OtpAuthenticationService {

    private static final Logger log = LoggerFactory.getLogger(OtpAuthenticationService.class);

    private static final int OTP_EXPIRY_MINUTES = 5;
    private static final int RESEND_COOLDOWN_SECONDS = 60;
    private static final int MAX_ATTEMPTS = 5;
    private static final int MAX_REQUESTS_PER_WINDOW = 5;
    private static final int RATE_LIMIT_WINDOW_MINUTES = 15;

    private final OtpVerificationRepository otpRepository;
    private final CustomerRepository customerRepository;
    private final EmailService emailService;
    private final PasswordEncoder passwordEncoder;
    private final SecureRandom secureRandom;

    public OtpAuthenticationService(OtpVerificationRepository otpRepository,
                                    CustomerRepository customerRepository,
                                    EmailService emailService) {
        this.otpRepository = otpRepository;
        this.customerRepository = customerRepository;
        this.emailService = emailService;
        this.passwordEncoder = new BCryptPasswordEncoder();
        this.secureRandom = new SecureRandom();
    }

    /**
     * Verifies customer credentials (email + BCrypt password).
     * If valid, generates a secure 6-digit OTP, stores its BCrypt hash in MySQL,
     * and sends the email via the transactional email provider.
     * Enforces 60-second cooldown and anti-spam rate limits.
     * If credentials are invalid, rejects with generic error and does NOT send OTP.
     */
    @Transactional
    public void sendLoginOtp(String rawEmail, String rawPassword) {
        if (rawEmail == null || rawEmail.trim().isEmpty()) {
            throw new IllegalArgumentException("Email address is required.");
        }
        if (rawPassword == null || rawPassword.trim().isEmpty()) {
            throw new IllegalArgumentException("Password is required.");
        }

        String email = rawEmail.trim().toLowerCase();

        // 1. Verify customer exists in database
        Optional<Customer> customerOpt = customerRepository.findByEmail(email);
        if (customerOpt.isEmpty()) {
            log.warn("Login OTP request failed: email {} not registered.", maskEmail(email));
            throw new IllegalArgumentException("Invalid email or password.");
        }

        Customer customer = customerOpt.get();

        // 2. Verify password with BCrypt PasswordEncoder
        if (!passwordEncoder.matches(rawPassword, customer.getPassword())) {
            log.warn("Login OTP request failed: incorrect password for email {}.", maskEmail(email));
            throw new IllegalArgumentException("Invalid email or password.");
        }

        // 3. Anti-spam rate limiting: max 5 requests per 15 minutes
        LocalDateTime rateLimitCutoff = LocalDateTime.now().minusMinutes(RATE_LIMIT_WINDOW_MINUTES);
        long recentRequests = otpRepository.countByEmailAndCreatedAtAfter(email, rateLimitCutoff);
        if (recentRequests >= MAX_REQUESTS_PER_WINDOW) {
            throw new IllegalArgumentException("Too many OTP requests. Please wait a few minutes before trying again.");
        }

        // 4. Resend cooldown enforcement (60 seconds)
        Optional<OtpVerification> latestOtpOpt = otpRepository.findTopByEmailAndVerifiedFalseOrderByCreatedAtDesc(email);
        if (latestOtpOpt.isPresent()) {
            OtpVerification latest = latestOtpOpt.get();
            LocalDateTime now = LocalDateTime.now();
            long elapsedSeconds = Duration.between(latest.getCreatedAt(), now).getSeconds();
            if (elapsedSeconds < RESEND_COOLDOWN_SECONDS && !latest.isExpired()) {
                long waitSeconds = RESEND_COOLDOWN_SECONDS - elapsedSeconds;
                throw new IllegalArgumentException("Please wait " + waitSeconds + " seconds before requesting a new verification code.");
            }
        }

        // 5. Invalidate previous active OTPs for this email
        otpRepository.invalidatePreviousOtps(email);

        // 6. Generate cryptographically secure random 6-digit OTP
        String otpCode = String.format("%06d", secureRandom.nextInt(1_000_000));

        // 7. Securely hash OTP before database persistence
        String hashedOtp = passwordEncoder.encode(otpCode);
        LocalDateTime expiresAt = LocalDateTime.now().plusMinutes(OTP_EXPIRY_MINUTES);

        OtpVerification record = new OtpVerification(email, hashedOtp, expiresAt);
        record.setMaxAttempts(MAX_ATTEMPTS);
        record.setAttempts(0);
        record.setVerified(false);
        otpRepository.save(record);

        // 8. Dispatch real transactional email (never logging the code)
        log.info("Credentials verified for customer ID {}. Dispatched login OTP email.", customer.getCustomerId());
        emailService.sendOtpEmail(email, customer.getFullName(), otpCode);
    }

    /**
     * Verifies the 6-digit OTP against the stored BCrypt hash.
     * Enforces expiration (5 minutes), attempt limit (max 5), and single-use invalidation.
     * Returns the authenticated Customer upon success.
     */
    @Transactional
    public Customer verifyLoginOtp(String rawEmail, String rawOtp) {
        if (rawEmail == null || rawEmail.trim().isEmpty()) {
            throw new IllegalArgumentException("Email address is required.");
        }
        if (rawOtp == null || rawOtp.trim().isEmpty()) {
            throw new IllegalArgumentException("Verification code is required.");
        }

        String email = rawEmail.trim().toLowerCase();
        String otp = rawOtp.trim();

        if (!otp.matches("^[0-9]{6}$")) {
            throw new IllegalArgumentException("Verification code must be a 6-digit number.");
        }

        // 1. Fetch latest unverified OTP record
        OtpVerification record = otpRepository.findTopByEmailAndVerifiedFalseOrderByCreatedAtDesc(email)
                .orElseThrow(() -> new IllegalArgumentException("No active verification code found for this email. Please request a new code."));

        // 2. Check if already verified
        if (Boolean.TRUE.equals(record.getVerified())) {
            throw new IllegalArgumentException("This verification code has already been used. Please request a new code.");
        }

        // 3. Check expiration
        if (record.isExpired()) {
            record.setVerified(true); // Invalidate expired record
            otpRepository.save(record);
            throw new IllegalArgumentException("The verification code has expired (5-minute limit). Please request a new code.");
        }

        // 4. Check maximum attempts limit
        if (record.hasExceededAttempts()) {
            record.setVerified(true); // Invalidate locked record
            otpRepository.save(record);
            throw new IllegalArgumentException("Maximum verification attempts exceeded (5/5). Please request a new code.");
        }

        // 5. Verify OTP match using BCrypt
        boolean matches = passwordEncoder.matches(otp, record.getOtpHash());
        if (!matches) {
            int updatedAttempts = record.getAttempts() + 1;
            record.setAttempts(updatedAttempts);
            otpRepository.save(record);

            int remaining = MAX_ATTEMPTS - updatedAttempts;
            if (remaining <= 0) {
                record.setVerified(true);
                otpRepository.save(record);
                throw new IllegalArgumentException("Incorrect verification code. Maximum attempts exceeded. Please request a new code.");
            }
            throw new IllegalArgumentException("Incorrect verification code. " + remaining + " " + (remaining == 1 ? "attempt" : "attempts") + " remaining.");
        }

        // 6. Mark record as verified (single-use)
        record.setVerified(true);
        otpRepository.save(record);

        // 7. Retrieve authenticated Customer
        Customer customer = customerRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("Customer account not found."));

        log.info("Customer ID {} ({}) successfully verified email OTP.", customer.getCustomerId(), maskEmail(email));
        return customer;
    }

    private String maskEmail(String email) {
        if (email == null || !email.contains("@")) return "***@***.***";
        String[] parts = email.split("@");
        String name = parts[0];
        String domain = parts[1];
        if (name.length() <= 2) {
            return name.charAt(0) + "*@" + domain;
        }
        return name.charAt(0) + "***" + name.charAt(name.length() - 1) + "@" + domain;
    }
}
