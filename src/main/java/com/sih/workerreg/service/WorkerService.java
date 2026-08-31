package com.sih.workerreg.service;

import com.sih.workerreg.dto.WorkerRegistrationDto;
import com.sih.workerreg.model.Worker;
import com.sih.workerreg.repository.WorkerRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class WorkerService {

    private final WorkerRepository workerRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public WorkerService(WorkerRepository workerRepository) {
        this.workerRepository = workerRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    /**
     * Registers a new worker from the submitted form data and saves into MySQL.
     * Validates that email and phone are not already registered.
     *
     * @param dto the validated registration data
     * @return the saved Worker entity with auto-generated ID
     */
    @Transactional
    public Worker registerWorker(WorkerRegistrationDto dto) {
        // Validate duplicate email
        String emailClean = dto.getEmail().trim().toLowerCase();
        if (workerRepository.existsByEmail(emailClean)) {
            throw new IllegalArgumentException("An account with email '" + dto.getEmail() + "' already exists.");
        }

        // Validate duplicate phone
        String phoneClean = dto.getPhone().trim();
        if (workerRepository.existsByPhone(phoneClean)) {
            throw new IllegalArgumentException("A worker with phone number '" + dto.getPhone() + "' already exists.");
        }

        Worker worker = new Worker();
        worker.setFullName(dto.getFullName().trim());
        worker.setPhone(phoneClean);
        worker.setEmail(emailClean);

        // Hash password securely using BCrypt
        String rawPass = (dto.getPassword() != null && !dto.getPassword().trim().isEmpty())
                ? dto.getPassword()
                : "Password@123";
        worker.setPassword(passwordEncoder.encode(rawPass));

        worker.setSkill(dto.getSkill().trim());
        worker.setExperienceYears(dto.getExperienceYears());
        worker.setLocation(dto.getLocation().trim());
        
        // Handle optional invitedBy field
        if (dto.getInvitedBy() != null && !dto.getInvitedBy().trim().isEmpty()) {
            worker.setInvitedBy(dto.getInvitedBy().trim());
        } else {
            worker.setInvitedBy("Self");
        }

        // Saves to MySQL and populates worker_id & created_at
        return workerRepository.save(worker);
    }

    /**
     * Authenticates worker credentials using BCrypt password matching.
     */
    @Transactional(readOnly = true)
    public Worker authenticate(String email, String rawPassword) {
        String cleanEmail = email != null ? email.trim().toLowerCase() : "";
        Worker worker = workerRepository.findByEmail(cleanEmail)
                .orElseThrow(() -> new IllegalArgumentException("Invalid email or password."));

        if (worker.getPassword() == null || !passwordEncoder.matches(rawPassword, worker.getPassword())) {
            throw new IllegalArgumentException("Invalid email or password.");
        }

        return worker;
    }

    /**
     * Fetch all registered workers (ordered by latest first).
     */
    @Transactional(readOnly = true)
    public List<Worker> getAllWorkers() {
        return workerRepository.findAllByOrderByCreatedAtDesc();
    }

    /**
     * Search workers by skill with intelligent keyword matching
     * (e.g. 'Plumbing' matches 'Plumber' & 'Plumbing').
     */
    @Transactional(readOnly = true)
    public List<Worker> searchWorkersBySkill(String skill) {
        if (skill == null || skill.trim().isEmpty()) {
            return getAllWorkers();
        }

        String cleaned = skill.trim().toLowerCase();

        // Skill synonym mapping for better matching against free-text worker skills
        if (cleaned.contains("plumb")) {
            return workerRepository.findBySkillContainingIgnoreCaseOrderByCreatedAtDesc("plumb");
        } else if (cleaned.contains("electric")) {
            return workerRepository.findBySkillContainingIgnoreCaseOrderByCreatedAtDesc("electr");
        } else if (cleaned.contains("cook")) {
            return workerRepository.findBySkillFuzzy("cook", "chef");
        } else if (cleaned.contains("clean")) {
            return workerRepository.findBySkillContainingIgnoreCaseOrderByCreatedAtDesc("clean");
        } else if (cleaned.contains("ac") || cleaned.contains("air")) {
            return workerRepository.findBySkillFuzzy("ac", "hvac");
        } else if (cleaned.contains("mason") || cleaned.contains("construct")) {
            return workerRepository.findBySkillFuzzy("mason", "construct");
        } else if (cleaned.contains("driv")) {
            return workerRepository.findBySkillContainingIgnoreCaseOrderByCreatedAtDesc("driv");
        } else if (cleaned.contains("carpent")) {
            return workerRepository.findBySkillContainingIgnoreCaseOrderByCreatedAtDesc("carpent");
        } else if (cleaned.contains("paint")) {
            return workerRepository.findBySkillContainingIgnoreCaseOrderByCreatedAtDesc("paint");
        } else if (cleaned.contains("laund")) {
            return workerRepository.findBySkillFuzzy("laund", "tailor");
        }

        return workerRepository.findBySkillContainingIgnoreCaseOrderByCreatedAtDesc(cleaned);
    }

    /**
     * Search workers by city with intelligent locality matching.
     */
    @Transactional(readOnly = true)
    public List<Worker> searchWorkersByCity(String city) {
        if (city == null || city.trim().isEmpty()) {
            return getAllWorkers();
        }
        String cleanCity = extractCity(city);
        return workerRepository.findByCityIgnoreCase(cleanCity);
    }

    /**
     * Fetch nearby workers matching the customer's city with optional skill and status filters.
     * Guaranteed to exclude workers from other cities.
     */
    @Transactional(readOnly = true)
    public List<Worker> getNearbyWorkers(String city, String skill, String status) {
        if (city == null || city.trim().isEmpty()) {
            return List.of();
        }

        String cleanCity = extractCity(city);
        boolean hasSkill = skill != null && !skill.trim().isEmpty();
        boolean hasStatus = status != null && !status.trim().isEmpty();

        if (!hasSkill && !hasStatus) {
            return workerRepository.findByCityIgnoreCase(cleanCity);
        }

        String cleanSkill = hasSkill ? skill.trim() : null;
        String cleanStatus = hasStatus ? status.trim() : null;

        return workerRepository.findNearbyWorkersByCity(cleanCity, cleanSkill, cleanStatus);
    }


    /**
     * Helper to extract the primary city name from location strings
     * (e.g., "Aliganj, Lucknow" -> "Lucknow", "Gomti Nagar, Lucknow" -> "Lucknow", "Lucknow" -> "Lucknow").
     */
    public static String extractCity(String location) {
        if (location == null || location.trim().isEmpty()) {
            return "";
        }
        String trimmed = location.trim();
        if (trimmed.contains(",")) {
            String[] parts = trimmed.split(",");
            String lastPart = parts[parts.length - 1].trim();
            if (!lastPart.isEmpty()) {
                return lastPart;
            }
        }
        if (trimmed.toLowerCase().endsWith(" hq")) {
            return trimmed.substring(0, trimmed.length() - 3).trim();
        }
        return trimmed;
    }

    /**
     * Fetch a worker by primary key ID.
     */
    @Transactional(readOnly = true)
    public Optional<Worker> getWorkerById(Long id) {
        return workerRepository.findById(id);
    }
}

