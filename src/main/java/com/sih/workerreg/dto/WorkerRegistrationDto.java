package com.sih.workerreg.dto;

import jakarta.validation.constraints.*;

public class WorkerRegistrationDto {

    @NotBlank(message = "Full Name is required")
    @Size(min = 2, max = 100, message = "Full Name must be between 2 and 100 characters")
    private String fullName;

    @NotBlank(message = "Mobile Number is required")
    @Pattern(regexp = "^[0-9+\\-\\s]{7,20}$", message = "Please enter a valid phone number (digits only or with country code)")
    private String phone;

    @NotBlank(message = "Email Address is required")
    @Email(message = "Please enter a valid email address")
    @Size(max = 100, message = "Email cannot exceed 100 characters")
    private String email;

    @NotBlank(message = "Work/Skill is required")
    @Size(max = 100, message = "Skill cannot exceed 100 characters")
    private String skill;

    @NotNull(message = "Years of Experience is required")
    @Min(value = 0, message = "Experience years cannot be negative")
    @Max(value = 70, message = "Experience years must be 70 or less")
    private Integer experienceYears;

    @NotBlank(message = "Location is required")
    @Size(max = 150, message = "Location cannot exceed 150 characters")
    private String location;

    @Size(max = 100, message = "Invited By cannot exceed 100 characters")
    private String invitedBy;

    public WorkerRegistrationDto() {
    }

    public WorkerRegistrationDto(String fullName, String phone, String email, String skill, Integer experienceYears, String location, String invitedBy) {
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.skill = skill;
        this.experienceYears = experienceYears;
        this.location = location;
        this.invitedBy = invitedBy;
    }

    // Getters and Setters
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

    public String getInvitedBy() {
        return invitedBy;
    }

    public void setInvitedBy(String invitedBy) {
        this.invitedBy = invitedBy;
    }
}
