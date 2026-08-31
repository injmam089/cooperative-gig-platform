package com.sih.workerreg.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "services", indexes = {
    @Index(name = "idx_service_name", columnList = "service_name")
})
public class ServiceItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "service_id")
    private Long serviceId;

    @Column(name = "service_name", nullable = false, length = 100)
    private String serviceName;

    @Column(name = "description", nullable = false, columnDefinition = "TEXT")
    private String description;

    @Column(name = "icon", length = 50)
    private String icon = "🛠️";

    @Column(name = "base_price", nullable = false)
    private Double basePrice = 299.0;

    @Column(name = "minimum_charge", nullable = false)
    private Double minimumCharge = 199.0;

    @Column(name = "hourly_rate", nullable = false)
    private Double hourlyRate = 150.0;

    @Column(name = "emergency_fee", nullable = false)
    private Double emergencyFee = 150.0;

    @Column(name = "is_active", nullable = false)
    private Boolean active = true;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    public ServiceItem() {
    }

    public ServiceItem(String serviceName, String description, String icon) {
        this.serviceName = serviceName;
        this.description = description;
        this.icon = icon;
        this.basePrice = 299.0;
        this.minimumCharge = 199.0;
        this.hourlyRate = 150.0;
        this.emergencyFee = 150.0;
        this.active = true;
    }

    public ServiceItem(String serviceName, String description, String icon, Double basePrice, Double minimumCharge, Double hourlyRate, Double emergencyFee) {
        this.serviceName = serviceName;
        this.description = description;
        this.icon = icon;
        this.basePrice = basePrice;
        this.minimumCharge = minimumCharge;
        this.hourlyRate = hourlyRate;
        this.emergencyFee = emergencyFee;
        this.active = true;
    }

    @PrePersist
    protected void onCreate() {
        if (this.createdAt == null) {
            this.createdAt = LocalDateTime.now();
        }
        if (this.active == null) {
            this.active = true;
        }
        if (this.basePrice == null) {
            this.basePrice = 299.0;
        }
        if (this.minimumCharge == null) {
            this.minimumCharge = 199.0;
        }
        if (this.hourlyRate == null) {
            this.hourlyRate = 150.0;
        }
        if (this.emergencyFee == null) {
            this.emergencyFee = 150.0;
        }
    }

    // Getters and Setters
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

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Double getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(Double basePrice) {
        this.basePrice = basePrice;
    }

    public Double getMinimumCharge() {
        return minimumCharge;
    }

    public void setMinimumCharge(Double minimumCharge) {
        this.minimumCharge = minimumCharge;
    }

    public Double getHourlyRate() {
        return hourlyRate;
    }

    public void setHourlyRate(Double hourlyRate) {
        this.hourlyRate = hourlyRate;
    }

    public Double getEmergencyFee() {
        return emergencyFee;
    }

    public void setEmergencyFee(Double emergencyFee) {
        this.emergencyFee = emergencyFee;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
