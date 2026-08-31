package com.sih.workerreg.controller;

import com.sih.workerreg.dto.CustomerLoginDto;
import com.sih.workerreg.dto.CustomerResponseDto;
import com.sih.workerreg.dto.CustomerSignUpDto;
import com.sih.workerreg.model.Customer;
import com.sih.workerreg.service.CustomerService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;


@RestController
@RequestMapping("/api/customers")
@CrossOrigin(originPatterns = "*", allowCredentials = "true")
public class CustomerController {

    private final CustomerService customerService;
    private final com.sih.workerreg.service.OtpAuthenticationService otpAuthService;

    public CustomerController(CustomerService customerService,
                              com.sih.workerreg.service.OtpAuthenticationService otpAuthService) {
        this.customerService = customerService;
        this.otpAuthService = otpAuthService;
    }

    /**
     * POST /api/customers/send-otp
     * Verifies email + password credentials and dispatches a single-use 6-digit OTP to the customer's email.
     */
    @PostMapping("/send-otp")
    public ResponseEntity<Map<String, Object>> sendOtp(@Valid @RequestBody com.sih.workerreg.dto.SendOtpRequestDto dto) {
        otpAuthService.sendLoginOtp(dto.getEmail(), dto.getPassword());

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "A 6-digit verification code has been sent to your email.");
        return ResponseEntity.ok(response);
    }

    /**
     * POST /api/customers/verify-otp
     * Verifies the 6-digit OTP and creates the customer HTTP session.
     */
    @PostMapping("/verify-otp")
    public ResponseEntity<Map<String, Object>> verifyOtp(@Valid @RequestBody com.sih.workerreg.dto.VerifyOtpRequestDto dto,
                                                         jakarta.servlet.http.HttpServletRequest request) {
        Customer customer = otpAuthService.verifyLoginOtp(dto.getEmail(), dto.getOtp());

        // Invalidate old session and create a new session
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }
        HttpSession newSession = request.getSession(true);

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

    /**
     * POST /api/customers
     * Registers a new customer with BCrypt hashed password into MySQL and starts a session.
     */
    @PostMapping
    public ResponseEntity<Map<String, Object>> registerCustomer(@Valid @RequestBody CustomerSignUpDto dto, HttpSession session) {
        Customer savedCustomer = customerService.registerCustomer(dto);
        CustomerResponseDto responseDto = new CustomerResponseDto(savedCustomer);

        // Automatically bind customer ID into session on successful registration
        if (session != null) {
            session.setAttribute("CUSTOMER_ID", savedCustomer.getCustomerId());
            session.setAttribute("CUSTOMER_EMAIL", savedCustomer.getEmail());
            session.setAttribute("CUSTOMER_NAME", savedCustomer.getFullName());
            session.setAttribute("ROLE", "CUSTOMER");
        }

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Customer account registered successfully in MySQL database!");
        response.put("customerId", savedCustomer.getCustomerId());
        response.put("data", responseDto);
        response.put("customer", responseDto);

        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    /**
     * POST /api/customers/login
     * Authenticates customer credentials (Email + BCrypt Password) and creates an authenticated HTTP session.
     */
    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> loginCustomer(@Valid @RequestBody CustomerLoginDto dto,
                                                             HttpServletRequest request) {
        Customer customer = customerService.authenticate(dto.getEmail(), dto.getPassword());

        // Invalidate old session to prevent session fixation and create a clean authenticated session
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
        response.put("data", responseDto);
        response.put("customer", responseDto);

        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/customers/me
     * Returns currently authenticated customer's safe information from session.
     */
    @GetMapping("/me")
    public ResponseEntity<?> getCurrentCustomer(HttpSession session) {
        Long customerId = session != null ? (Long) session.getAttribute("CUSTOMER_ID") : null;
        if (customerId == null) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("authenticated", false);
            error.put("message", "Unauthorized. No customer is currently logged in.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(error);
        }

        Optional<CustomerResponseDto> customerOpt = customerService.getCustomerById(customerId);
        if (customerOpt.isPresent()) {
            CustomerResponseDto dto = customerOpt.get();
            Map<String, Object> resp = new HashMap<>();
            resp.put("success", true);
            resp.put("authenticated", true);
            resp.put("customer", dto);
            resp.put("data", dto);
            resp.put("customerId", dto.getCustomerId());
            return ResponseEntity.ok(resp);
        }

        if (session != null) {
            session.invalidate();
        }
        Map<String, Object> error = new HashMap<>();
        error.put("success", false);
        error.put("authenticated", false);
        error.put("message", "Customer account not found.");
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(error);
    }

    /**
     * POST /api/customers/logout
     * Invalidates the current session.
     */
    @PostMapping("/logout")
    public ResponseEntity<Map<String, Object>> logoutCustomer(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Logged out successfully.");
        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/customers
     * Lists all registered customers for admin dashboard directory.
     */
    @GetMapping
    public ResponseEntity<List<CustomerResponseDto>> getAllCustomers() {
        List<CustomerResponseDto> customers = customerService.getAllCustomers();
        return ResponseEntity.ok(customers);
    }

    /**
     * GET /api/customers/{id}
     * Returns customer details by ID.
     */
    @GetMapping("/{id}")
    public ResponseEntity<?> getCustomerById(@PathVariable Long id) {
        return customerService.getCustomerById(id)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }
}


