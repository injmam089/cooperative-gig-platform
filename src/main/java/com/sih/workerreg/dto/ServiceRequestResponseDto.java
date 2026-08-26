package com.sih.workerreg.dto;

import com.sih.workerreg.model.ServiceRequest;
import java.time.LocalDateTime;

public class ServiceRequestResponseDto {

    private Long requestId;
    private Long customerId;
    private String customerName;
    private String customerPhone;
    private Long workerId;
    private String workerName;
    private String workerPhone;
    private String workerSkill;
    private Long serviceId;
    private String serviceName;
    private String description;
    private String location;
    private String preferredDate;
    private String preferredTime;
    private String status;
    private LocalDateTime createdAt;

    public ServiceRequestResponseDto() {
    }

    public ServiceRequestResponseDto(ServiceRequest req) {
        this.requestId = req.getRequestId();
        if (req.getCustomer() != null) {
            this.customerId = req.getCustomer().getCustomerId();
            this.customerName = req.getCustomer().getFullName();
            this.customerPhone = req.getCustomer().getPhone();
        }
        if (req.getWorker() != null) {
            this.workerId = req.getWorker().getWorkerId();
            this.workerName = req.getWorker().getFullName();
            this.workerPhone = req.getWorker().getPhone();
            this.workerSkill = req.getWorker().getSkill();
        }
        if (req.getService() != null) {
            this.serviceId = req.getService().getServiceId();
            this.serviceName = req.getService().getServiceName();
        }
        this.description = req.getDescription();
        this.location = req.getLocation();
        this.preferredDate = req.getPreferredDate();
        this.preferredTime = req.getPreferredTime();
        this.status = req.getStatus();
        this.createdAt = req.getCreatedAt();
    }

    // Getters and Setters
    public Long getRequestId() {
        return requestId;
    }

    public void setRequestId(Long requestId) {
        this.requestId = requestId;
    }

    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public Long getWorkerId() {
        return workerId;
    }

    public void setWorkerId(Long workerId) {
        this.workerId = workerId;
    }

    public String getWorkerName() {
        return workerName;
    }

    public void setWorkerName(String workerName) {
        this.workerName = workerName;
    }

    public String getWorkerPhone() {
        return workerPhone;
    }

    public void setWorkerPhone(String workerPhone) {
        this.workerPhone = workerPhone;
    }

    public String getWorkerSkill() {
        return workerSkill;
    }

    public void setWorkerSkill(String workerSkill) {
        this.workerSkill = workerSkill;
    }

    public Long getServiceId() {
        return serviceId;
    }

    public void setServiceId(Long serviceId) {
        this.serviceId = serviceId;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
