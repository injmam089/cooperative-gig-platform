package com.sih.workerreg.dto;

import com.sih.workerreg.model.Customer;
import java.time.LocalDateTime;

public class CustomerResponseDto {

    private Long customerId;
    private String fullName;
    private String phone;
    private String email;
    private String location;
    private String address;
    private LocalDateTime createdAt;

    public CustomerResponseDto() {
    }

    public CustomerResponseDto(Customer customer) {
        this.customerId = customer.getCustomerId();
        this.fullName = customer.getFullName();
        this.phone = customer.getPhone();
        this.email = customer.getEmail();
        this.location = customer.getLocation();
        this.address = customer.getAddress();
        this.createdAt = customer.getCreatedAt();
    }

    // Getters and Setters
    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
