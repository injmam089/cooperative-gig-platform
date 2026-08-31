package com.sih.workerreg.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;

@Service
public class SmtpEmailService implements EmailService {

    private static final Logger log = LoggerFactory.getLogger(SmtpEmailService.class);

    private final JavaMailSender mailSender;

    @Value("${app.mail.from:no-reply@cooperativegig.com}")
    private String fromAddress;

    @Value("${app.mail.from-name:Cooperative Gig Services}")
    private String fromPersonal;

    @Value("${app.mail.enabled:true}")
    private boolean mailEnabled;

    @Value("${spring.mail.username:}")
    private String mailUsername;

    public SmtpEmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    @Override
    public void sendOtpEmail(String toEmail, String recipientName, String otpCode) {
        if (!mailEnabled) {
            log.info("Email dispatch is disabled via configuration. Skipped sending OTP to {}", maskEmail(toEmail));
            return;
        }

        if (mailUsername == null || mailUsername.trim().isEmpty()) {
            log.warn("Real email delivery requires SMTP credentials. Please configure MAIL_USERNAME and MAIL_PASSWORD (in .env or environment variables).");
            throw new IllegalStateException("Email service is not configured. Please configure MAIL_USERNAME and MAIL_PASSWORD (in .env or environment variables) to enable real OTP email delivery.");
        }

        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(
                    message,
                    MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,
                    StandardCharsets.UTF_8.name()
            );

            try {
                helper.setFrom(fromAddress, fromPersonal);
            } catch (UnsupportedEncodingException e) {
                helper.setFrom(fromAddress);
            }

            helper.setTo(toEmail);
            helper.setSubject("Your Login Verification Code: " + otpCode.substring(0, 3) + " " + otpCode.substring(3));

            String htmlBody = buildOtpHtmlTemplate(recipientName, otpCode);
            String plainText = buildOtpPlainText(recipientName, otpCode);

            helper.setText(plainText, htmlBody);

            mailSender.send(message);
            log.info("Successfully dispatched OTP verification email to recipient {}", maskEmail(toEmail));

        } catch (org.springframework.mail.MailAuthenticationException | jakarta.mail.AuthenticationFailedException e) {
            log.error("SMTP Authentication Failed while delivering OTP to {}. Verify MAIL_USERNAME and MAIL_PASSWORD.", maskEmail(toEmail));
            throw new IllegalStateException("SMTP authentication failed. Please verify your MAIL_USERNAME and MAIL_PASSWORD credentials.");
        } catch (org.springframework.mail.MailSendException e) {
            Throwable root = e.getRootCause();
            if (root instanceof jakarta.mail.AuthenticationFailedException || (root != null && root.getMessage() != null && root.getMessage().toLowerCase().contains("authentication"))) {
                log.error("SMTP Authentication Failed for recipient {}.", maskEmail(toEmail));
                throw new IllegalStateException("SMTP authentication failed. Please verify your MAIL_USERNAME and MAIL_PASSWORD credentials.");
            } else if (root instanceof java.net.ConnectException || (root != null && root.getMessage() != null && (root.getMessage().toLowerCase().contains("connection") || root.getMessage().toLowerCase().contains("timed out")))) {
                log.error("SMTP Connection Failed while connecting to mail host.");
                throw new IllegalStateException("Unable to connect to the email server. Please check your network connection or MAIL_HOST setting.");
            }
            log.error("Failed to deliver OTP email to {}. Error: {}", maskEmail(toEmail), e.getMessage());
            throw new IllegalStateException("Unable to send verification email. Please check your network connection or try again later.");
        } catch (MessagingException | MailException e) {
            log.error("Failed to deliver OTP email to {}. Root cause: {}", maskEmail(toEmail), e.getMessage());
            throw new IllegalStateException("Unable to send verification email. Please check your network connection or try again later.");
        }
    }

    private String buildOtpHtmlTemplate(String recipientName, String otpCode) {
        String safeName = (recipientName != null && !recipientName.trim().isEmpty())
                ? escapeHtml(recipientName.trim())
                : "Valued Customer";

        return "<!DOCTYPE html>" +
                "<html lang=\"en\">" +
                "<head>" +
                "  <meta charset=\"UTF-8\">" +
                "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">" +
                "  <title>Your Verification Code</title>" +
                "  <style>" +
                "    body { margin: 0; padding: 0; background-color: #f1f5f9; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; color: #0f172a; }" +
                "    .email-container { max-width: 560px; margin: 30px auto; background: #ffffff; border-radius: 16px; overflow: hidden; border: 1px solid #e2e8f0; box-shadow: 0 4px 20px rgba(0,0,0,0.06); }" +
                "    .header { background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%); padding: 32px 24px; text-align: center; color: #ffffff; }" +
                "    .header-badge { display: inline-block; background: rgba(255,255,255,0.18); border: 1px solid rgba(255,255,255,0.3); border-radius: 999px; padding: 4px 14px; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.08em; margin-bottom: 12px; }" +
                "    .header h1 { margin: 0; font-size: 22px; font-weight: 800; letter-spacing: -0.02em; }" +
                "    .content { padding: 36px 32px; }" +
                "    .greeting { font-size: 16px; font-weight: 700; color: #1e293b; margin-bottom: 12px; }" +
                "    .message { font-size: 14px; line-height: 1.6; color: #475569; margin-bottom: 28px; }" +
                "    .otp-box { background: #f8fafc; border: 2px dashed #93c5fd; border-radius: 12px; padding: 24px; text-align: center; margin: 24px 0; }" +
                "    .otp-label { font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.06em; color: #2563eb; margin-bottom: 8px; }" +
                "    .otp-code { font-size: 34px; font-weight: 900; letter-spacing: 10px; color: #1e3a8a; font-family: 'Courier New', Courier, monospace; margin: 0; }" +
                "    .expiry-note { font-size: 13px; color: #dc2626; font-weight: 600; text-align: center; margin-top: 10px; }" +
                "    .security-card { background: #f8fafc; border-left: 4px solid #3b82f6; border-radius: 8px; padding: 14px 18px; font-size: 13px; color: #64748b; line-height: 1.5; margin-top: 24px; }" +
                "    .footer { background: #f8fafc; border-top: 1px solid #e2e8f0; padding: 24px; text-align: center; font-size: 12px; color: #94a3b8; }" +
                "  </style>" +
                "</head>" +
                "<body>" +
                "  <div class=\"email-container\">" +
                "    <div class=\"header\">" +
                "      <div class=\"header-badge\">COOPERATIVE GIG SERVICES</div>" +
                "      <h1>Customer Portal Login</h1>" +
                "    </div>" +
                "    <div class=\"content\">" +
                "      <div class=\"greeting\">Hello, " + safeName + "!</div>" +
                "      <p class=\"message\">We received a request to log in to your Cooperative Gig Services account. Use the single-use 6-digit verification code below to complete your login:</p>" +
                "      <div class=\"otp-box\">" +
                "        <div class=\"otp-label\">Your Verification Code</div>" +
                "        <div class=\"otp-code\">" + escapeHtml(otpCode) + "</div>" +
                "        <div class=\"expiry-note\">⏱ Valid for 5 minutes only</div>" +
                "      </div>" +
                "      <div class=\"security-card\">" +
                "        <strong>🛡 Security Tip:</strong> Never share this code with anyone. Cooperative support staff will never ask for your verification code. If you did not request this login, you can safely ignore this email." +
                "      </div>" +
                "    </div>" +
                "    <div class=\"footer\">" +
                "      &copy; 2026 Cooperative Gig Services Platform &bull; Empowering Local Skilled Artisans<br>" +
                "      This is an automated transactional message. Please do not reply directly to this email." +
                "    </div>" +
                "  </div>" +
                "</body>" +
                "</html>";
    }

    private String buildOtpPlainText(String recipientName, String otpCode) {
        String safeName = (recipientName != null && !recipientName.trim().isEmpty())
                ? recipientName.trim()
                : "Valued Customer";

        return "Cooperative Gig Services - Customer Login Verification\n\n" +
                "Hello " + safeName + ",\n\n" +
                "Your 6-digit verification code is:\n" +
                "------------------------------------\n" +
                "         " + otpCode + "\n" +
                "------------------------------------\n\n" +
                "This code will expire in 5 minutes and is single-use only.\n\n" +
                "If you did not request this code, please safely ignore this email.\n\n" +
                "(c) 2026 Cooperative Gig Services Platform";
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

    private String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}
