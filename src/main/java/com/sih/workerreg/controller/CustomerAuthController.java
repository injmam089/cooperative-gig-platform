package com.sih.workerreg.controller;

import com.sih.workerreg.dto.CustomerResponseDto;
import com.sih.workerreg.dto.SendOtpRequestDto;
import com.sih.workerreg.dto.VerifyOtpRequestDto;
import com.sih.workerreg.model.Customer;
import com.sih.workerreg.service.OtpAuthenticationService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

import com.sih.workerreg.dto.CustomerLoginDto;
import com.sih.workerreg.service.CustomerService;

@RestController
@RequestMapping({"/api/auth", "/api/customers/auth"})
@CrossOrigin(originPatterns = "*", allowCredentials = "true")
public class CustomerAuthController {

    private final CustomerService customerService;
    private final OtpAuthenticationService otpAuthService;

    public CustomerAuthController(CustomerService customerService, OtpAuthenticationService otpAuthService) {
        this.customerService = customerService;
        this.otpAuthService = otpAuthService;
    }

    /**
     * POST /api/auth/login
     * Authenticates customer credentials (Email + BCrypt Password) and creates an authenticated HTTP session.
     */
    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> login(@Valid @RequestBody CustomerLoginDto dto,
                                                     HttpServletRequest request) {
        Customer customer = customerService.authenticate(dto.getEmail(), dto.getPassword());

        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }
        HttpSession session = request.getSession(true);

        session.setAttribute("CUSTOMER_ID", customer.getCustomerId());
        session.setAttribute("CUSTOMER_EMAIL", customer.getEmail());
        session.setAttribute("CUSTOMER_NAME", customer.getFullName());
        session.setAttribute("ROLE", "CUSTOMER");

        CustomerResponseDto responseDto = new CustomerResponseDto(customer);

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("authenticated", true);
        response.put("message", "Logged in successfully!");
        response.put("customerId", customer.getCustomerId());
        response.put("customer", responseDto);
        response.put("data", responseDto);

        return ResponseEntity.ok(response);
    }

    /**
     * POST /api/auth/send-otp
     * Verifies email + password credentials and dispatches a single-use 6-digit OTP.
     */
    @PostMapping("/send-otp")
    public ResponseEntity<Map<String, Object>> sendOtp(@Valid @RequestBody SendOtpRequestDto dto) {
        otpAuthService.sendLoginOtp(dto.getEmail(), dto.getPassword());

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "A 6-digit verification code has been sent to your email.");
        return ResponseEntity.ok(response);
    }

    /**
     * POST /api/auth/verify-otp
     * Verifies the 6-digit OTP, creates the authenticated HTTP session,
     * and returns the logged-in customer profile.
     */
    @PostMapping("/verify-otp")
    public ResponseEntity<Map<String, Object>> verifyOtp(@Valid @RequestBody VerifyOtpRequestDto dto,
                                                         HttpServletRequest request) {
        Customer customer = otpAuthService.verifyLoginOtp(dto.getEmail(), dto.getOtp());

        // Invalidate old session to prevent session fixation, then create a new authenticated session
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }
        HttpSession newSession = request.getSession(true);

        // Bind standard customer session attributes
        newSession.setAttribute("CUSTOMER_ID", customer.getCustomerId());
        newSession.setAttribute("CUSTOMER_EMAIL", customer.getEmail());
        newSession.setAttribute("CUSTOMER_NAME", customer.getFullName());
        newSession.setAttribute("ROLE", "CUSTOMER");

        CustomerResponseDto responseDto = new CustomerResponseDto(customer);

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("authenticated", true);
        response.put("message", "Logged in successfully!");
        response.put("customerId", customer.getCustomerId());
        response.put("customer", responseDto);
        response.put("data", responseDto);

        return ResponseEntity.ok(response);
    }
}
