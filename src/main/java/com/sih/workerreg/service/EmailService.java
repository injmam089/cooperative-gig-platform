package com.sih.workerreg.service;

/**
 * Service interface for transactional email delivery.
 * Allows switching or extending providers (Brevo, AWS SES, SendGrid, SMTP)
 * without impacting the core authentication logic.
 */
public interface EmailService {

    /**
     * Sends a 6-digit login verification OTP email to the specified recipient.
     *
     * @param toEmail       The recipient's email address
     * @param recipientName The recipient's display name
     * @param otpCode       The plain 6-digit OTP (never logged)
     */
    void sendOtpEmail(String toEmail, String recipientName, String otpCode);
}
