package com.sih.workerreg.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public class CreateServiceRequestDto {

    private Long customerId;


    @NotNull(message = "Worker ID is required")
    private Long workerId;

    @NotNull(message = "Service ID is required")
    private Long serviceId;

    @NotBlank(message = "Service description / issue details are required")
    @Size(max = 500, message = "Description cannot exceed 500 characters")
    private String description;

    @NotBlank(message = "Service location / address is required")
    @Size(max = 200, message = "Location cannot exceed 200 characters")
    private String location;

    @NotBlank(message = "Preferred date is required")
    private String preferredDate;

    @NotBlank(message = "Preferred time slot is required")
    private String preferredTime;

    public CreateServiceRequestDto() {
    }

    public CreateServiceRequestDto(Long customerId, Long workerId, Long serviceId, String description, String location, String preferredDate, String preferredTime) {
        this.customerId = customerId;
        this.workerId = workerId;
        this.serviceId = serviceId;
        this.description = description;
        this.location = location;
        this.preferredDate = preferredDate;
        this.preferredTime = preferredTime;
    }

    // Getters and Setters
    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

    public Long getWorkerId() {
        return workerId;
    }

    public void setWorkerId(Long workerId) {
        this.workerId = workerId;
    }

    public Long getServiceId() {
        return serviceId;
    }

    public void setServiceId(Long serviceId) {
        this.serviceId = serviceId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getPreferredDate() {
        return preferredDate;
    }

    public void setPreferredDate(String preferredDate) {
        this.preferredDate = preferredDate;
    }

    public String getPreferredTime() {
        return preferredTime;
    }

    public void setPreferredTime(String preferredTime) {
        this.preferredTime = preferredTime;
    }
}
