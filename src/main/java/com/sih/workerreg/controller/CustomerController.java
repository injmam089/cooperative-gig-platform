package com.sih.workerreg.controller;

import com.sih.workerreg.dto.CustomerLoginDto;
import com.sih.workerreg.dto.CustomerResponseDto;
import com.sih.workerreg.dto.CustomerSignUpDto;
import com.sih.workerreg.model.Customer;
import com.sih.workerreg.service.CustomerService;
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
@CrossOrigin(origins = "*")
public class CustomerController {

    private final CustomerService customerService;

    public CustomerController(CustomerService customerService) {
        this.customerService = customerService;
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
        }

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Customer account registered successfully in MySQL database!");
        response.put("customerId", savedCustomer.getCustomerId());
        response.put("data", responseDto);

        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    /**
     * POST /api/customers/login
     * Authenticates customer credentials and creates an authenticated session.
     */
    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> loginCustomer(@Valid @RequestBody CustomerLoginDto dto, HttpSession session) {
        Customer customer = customerService.authenticate(dto.getEmail(), dto.getPassword());
        
        // Store only the customer's ID in the session
        session.setAttribute("CUSTOMER_ID", customer.getCustomerId());

        CustomerResponseDto responseDto = new CustomerResponseDto(customer);

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Logged in successfully!");
        response.put("customerId", customer.getCustomerId());
        response.put("data", responseDto);

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
            error.put("message", "Unauthorized. No customer is currently logged in.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(error);
        }

        Optional<CustomerResponseDto> customerOpt = customerService.getCustomerById(customerId);
        if (customerOpt.isPresent()) {
            return ResponseEntity.ok(customerOpt.get());
        }

        if (session != null) {
            session.invalidate();
        }
        Map<String, Object> error = new HashMap<>();
        error.put("success", false);
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
     * Lists all registered customers (omits password hashes).
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

