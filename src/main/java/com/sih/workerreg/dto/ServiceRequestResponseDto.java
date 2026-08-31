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
    private Double rating;
    private String reviewNotes;
    private String disputeReason;
    private String disputeStatus;
    private String disputeResolution;
    private Double amountPaid;
    private LocalDateTime acceptedAt;
    private LocalDateTime startedAt;
    private LocalDateTime completedAt;
    private LocalDateTime createdAt;

    public ServiceRequestResponseDto() {
    }

    public ServiceRequestResponseDto(ServiceRequest req) {
        if (req == null) return;
        this.requestId = req.getRequestId();
        try {
            if (req.getCustomer() != null) {
                this.customerId = req.getCustomer().getCustomerId();
                this.customerName = req.getCustomer().getFullName();
                this.customerPhone = req.getCustomer().getPhone();
            }
        } catch (Exception ignored) {}
        try {
            if (req.getWorker() != null) {
                this.workerId = req.getWorker().getWorkerId();
                this.workerName = req.getWorker().getFullName();
                this.workerPhone = req.getWorker().getPhone();
                this.workerSkill = req.getWorker().getSkill();
            }
        } catch (Exception ignored) {}
        try {
            if (req.getService() != null) {
                this.serviceId = req.getService().getServiceId();
                this.serviceName = req.getService().getServiceName();
            }
        } catch (Exception ignored) {}
        this.description = req.getDescription() != null ? req.getDescription() : "";
        this.location = req.getLocation() != null ? req.getLocation() : "";
        this.preferredDate = req.getPreferredDate() != null ? req.getPreferredDate().toString() : "";
        this.preferredTime = req.getPreferredTime() != null ? req.getPreferredTime().toString() : "";
        this.status = req.getStatus() != null ? req.getStatus() : "PENDING";
        this.rating = req.getRating();
        this.reviewNotes = req.getReviewNotes();
        this.disputeReason = req.getDisputeReason();
        this.disputeStatus = req.getDisputeStatus() != null ? req.getDisputeStatus() : "NONE";
        this.disputeResolution = req.getDisputeResolution();
        this.amountPaid = req.getAmountPaid();
        this.acceptedAt = req.getAcceptedAt();
        this.startedAt = req.getStartedAt();
        this.completedAt = req.getCompletedAt();
        this.createdAt = req.getCreatedAt() != null ? req.getCreatedAt() : LocalDateTime.now();
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

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public String getReviewNotes() {
        return reviewNotes;
    }

    public void setReviewNotes(String reviewNotes) {
        this.reviewNotes = reviewNotes;
    }

    public String getDisputeReason() {
        return disputeReason;
    }

    public void setDisputeReason(String disputeReason) {
        this.disputeReason = disputeReason;
    }

    public String getDisputeStatus() {
        return disputeStatus;
    }

    public void setDisputeStatus(String disputeStatus) {
        this.disputeStatus = disputeStatus;
    }

    public String getDisputeResolution() {
        return disputeResolution;
    }

    public void setDisputeResolution(String disputeResolution) {
        this.disputeResolution = disputeResolution;
    }

    public Double getAmountPaid() {
        return amountPaid;
    }

    public void setAmountPaid(Double amountPaid) {
        this.amountPaid = amountPaid;
    }

    public LocalDateTime getAcceptedAt() {
        return acceptedAt;
    }

    public void setAcceptedAt(LocalDateTime acceptedAt) {
        this.acceptedAt = acceptedAt;
    }

    public LocalDateTime getStartedAt() {
        return startedAt;
    }

    public void setStartedAt(LocalDateTime startedAt) {
        this.startedAt = startedAt;
    }

    public LocalDateTime getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(LocalDateTime completedAt) {
        this.completedAt = completedAt;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
