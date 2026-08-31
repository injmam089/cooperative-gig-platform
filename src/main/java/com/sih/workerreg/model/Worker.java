package com.sih.workerreg.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "workers", indexes = {
    @Index(name = "idx_worker_phone", columnList = "phone"),
    @Index(name = "idx_worker_email", columnList = "email"),
    @Index(name = "idx_worker_status", columnList = "status"),
    @Index(name = "idx_worker_lat_lon", columnList = "latitude, longitude")
})
public class Worker {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "worker_id")
    private Long workerId;

    @Column(name = "full_name", nullable = false, length = 100)
    private String fullName;

    @Column(name = "phone", nullable = false, length = 20)
    private String phone;

    @Column(name = "email", nullable = false, unique = true, length = 100)
    private String email;

    @Column(name = "password", length = 255)
    private String password;

    @Column(name = "skill", nullable = false, length = 100)
    private String skill;

    @Column(name = "experience_years", nullable = false)
    private Integer experienceYears = 1;

    @Column(name = "location", nullable = false, length = 150)
    private String location;

    @Column(name = "latitude")
    private Double latitude = 26.8467;

    @Column(name = "longitude")
    private Double longitude = 80.9462;

    @Column(name = "service_radius_km")
    private Double serviceRadiusKm = 15.0;

    @Column(name = "status", nullable = false, length = 30)
    private String status = "VERIFIED";

    @Column(name = "current_availability", nullable = false, length = 30)
    private String currentAvailability = "AVAILABLE";

    @Column(name = "profile_photo", length = 255)
    private String profilePhoto;

    @Column(name = "bio", columnDefinition = "TEXT")
    private String bio;

    @Column(name = "average_rating")
    private Double averageRating = 4.8;

    @Column(name = "total_ratings")
    private Integer totalRatings = 12;

    @Column(name = "completed_jobs_count")
    private Integer completedJobsCount = 15;

    @Column(name = "working_days", length = 100)
    private String workingDays = "Mon, Tue, Wed, Thu, Fri, Sat";

    @Column(name = "shift_start_time", length = 20)
    private String shiftStartTime = "09:00 AM";

    @Column(name = "shift_end_time", length = 20)
    private String shiftEndTime = "07:00 PM";

    @Column(name = "verification_notes", columnDefinition = "TEXT")
    private String verificationNotes;

    @Column(name = "invited_by", length = 100)
    private String invitedBy = "Self";

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    public Worker() {
    }

    public Worker(String fullName, String phone, String email, String skill, Integer experienceYears, String location, String invitedBy) {
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.skill = skill;
        this.experienceYears = experienceYears != null ? experienceYears : 1;
        this.location = location;
        this.invitedBy = invitedBy != null ? invitedBy : "Self";
        this.status = "VERIFIED";
        this.currentAvailability = "AVAILABLE";
        this.averageRating = 4.8;
        this.totalRatings = 10;
        this.completedJobsCount = 12;
        this.latitude = 26.8467;
        this.longitude = 80.9462;
        this.serviceRadiusKm = 15.0;
        this.workingDays = "Mon, Tue, Wed, Thu, Fri, Sat";
        this.shiftStartTime = "09:00 AM";
        this.shiftEndTime = "07:00 PM";
    }

    @PrePersist
    protected void onCreate() {
        if (this.createdAt == null) {
            this.createdAt = LocalDateTime.now();
        }
        if (this.status == null) this.status = "VERIFIED";
        if (this.currentAvailability == null) this.currentAvailability = "AVAILABLE";
        if (this.averageRating == null) this.averageRating = 4.8;
        if (this.totalRatings == null) this.totalRatings = 0;
        if (this.completedJobsCount == null) this.completedJobsCount = 0;
        if (this.serviceRadiusKm == null) this.serviceRadiusKm = 15.0;
        if (this.latitude == null) this.latitude = 26.8467;
        if (this.longitude == null) this.longitude = 80.9462;
        if (this.workingDays == null) this.workingDays = "Mon, Tue, Wed, Thu, Fri, Sat";
        if (this.shiftStartTime == null) this.shiftStartTime = "09:00 AM";
        if (this.shiftEndTime == null) this.shiftEndTime = "07:00 PM";
    }

    // Getters and Setters
    public Long getWorkerId() {
        return workerId;
    }

    public void setWorkerId(Long workerId) {
        this.workerId = workerId;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSkill() {
        return skill;
    }

    public void setSkill(String skill) {
        this.skill = skill;
    }

    public Integer getExperienceYears() {
        return experienceYears;
    }

    public void setExperienceYears(Integer experienceYears) {
        this.experienceYears = experienceYears;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Double getServiceRadiusKm() {
        return serviceRadiusKm;
    }

    public void setServiceRadiusKm(Double serviceRadiusKm) {
        this.serviceRadiusKm = serviceRadiusKm;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCurrentAvailability() {
        return currentAvailability;
    }

    public void setCurrentAvailability(String currentAvailability) {
        this.currentAvailability = currentAvailability;
    }

    public String getProfilePhoto() {
        return profilePhoto;
    }

    public void setProfilePhoto(String profilePhoto) {
        this.profilePhoto = profilePhoto;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public Double getAverageRating() {
        return averageRating;
    }

    public void setAverageRating(Double averageRating) {
        this.averageRating = averageRating;
    }

    public Integer getTotalRatings() {
        return totalRatings;
    }

    public void setTotalRatings(Integer totalRatings) {
        this.totalRatings = totalRatings;
    }

    public Integer getCompletedJobsCount() {
        return completedJobsCount;
    }

    public void setCompletedJobsCount(Integer completedJobsCount) {
        this.completedJobsCount = completedJobsCount;
    }

    public String getVerificationNotes() {
        return verificationNotes;
    }

    public void setVerificationNotes(String verificationNotes) {
        this.verificationNotes = verificationNotes;
    }

    public String getInvitedBy() {
        return invitedBy;
    }

    public void setInvitedBy(String invitedBy) {
        this.invitedBy = invitedBy;
    }

    public String getWorkingDays() {
        return workingDays;
    }

    public void setWorkingDays(String workingDays) {
        this.workingDays = workingDays;
    }

    public String getShiftStartTime() {
        return shiftStartTime;
    }

    public void setShiftStartTime(String shiftStartTime) {
        this.shiftStartTime = shiftStartTime;
    }

    public String getShiftEndTime() {
        return shiftEndTime;
    }

    public void setShiftEndTime(String shiftEndTime) {
        this.shiftEndTime = shiftEndTime;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
