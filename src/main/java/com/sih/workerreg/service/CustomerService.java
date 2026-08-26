package com.sih.workerreg.service;

import com.sih.workerreg.dto.CustomerResponseDto;
import com.sih.workerreg.dto.CustomerSignUpDto;
import com.sih.workerreg.model.Customer;
import com.sih.workerreg.repository.CustomerRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CustomerService {

    private final CustomerRepository customerRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public CustomerService(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    /**
     * Registers a new customer with BCrypt password hashing and persists to MySQL.
     */
    @Transactional
    public Customer registerCustomer(CustomerSignUpDto dto) {
        // Validate password confirmation
        if (!dto.getPassword().equals(dto.getConfirmPassword())) {
            throw new IllegalArgumentException("Passwords do not match. Please verify and re-enter.");
        }

        // Check if email already exists
        if (customerRepository.existsByEmail(dto.getEmail().trim().toLowerCase())) {
            throw new IllegalArgumentException("An account with email '" + dto.getEmail() + "' already exists.");
        }

        // Hash password securely using BCrypt
        String hashedPassword = passwordEncoder.encode(dto.getPassword());

        Customer customer = new Customer();
        customer.setFullName(dto.getFullName().trim());
        customer.setPhone(dto.getPhone().trim());
        customer.setEmail(dto.getEmail().trim().toLowerCase());
        customer.setPassword(hashedPassword);
        customer.setLocation(dto.getLocation().trim());
        customer.setAddress(dto.getAddress().trim());

        return customerRepository.save(customer);
    }

    @Transactional(readOnly = true)
    public List<CustomerResponseDto> getAllCustomers() {
        return customerRepository.findAllByOrderByCreatedAtDesc()
                .stream()
                .map(CustomerResponseDto::new)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public Optional<CustomerResponseDto> getCustomerById(Long id) {
        return customerRepository.findById(id).map(CustomerResponseDto::new);
    }

    /**
     * Authenticates customer credentials using BCrypt password matching.
     */
    @Transactional(readOnly = true)
    public Customer authenticate(String email, String rawPassword) {
        Customer customer = customerRepository.findByEmail(email.trim().toLowerCase())
                .orElseThrow(() -> new IllegalArgumentException("Invalid email or password."));

        if (!passwordEncoder.matches(rawPassword, customer.getPassword())) {
            throw new IllegalArgumentException("Invalid email or password.");
        }

        return customer;
    }
}

