package com.sih.workerreg.service;

import com.sih.workerreg.dto.WorkerRegistrationDto;
import com.sih.workerreg.model.Worker;
import com.sih.workerreg.repository.WorkerRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class WorkerService {

    private final WorkerRepository workerRepository;

    public WorkerService(WorkerRepository workerRepository) {
        this.workerRepository = workerRepository;
    }

    /**
     * Registers a new worker from the submitted form data and saves into MySQL.
     *
     * @param dto the validated registration data
     * @return the saved Worker entity with auto-generated ID
     */
    @Transactional
    public Worker registerWorker(WorkerRegistrationDto dto) {
        Worker worker = new Worker();
        worker.setFullName(dto.getFullName().trim());
        worker.setPhone(dto.getPhone().trim());
        worker.setEmail(dto.getEmail().trim().toLowerCase());
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
     * Fetch a worker by primary key ID.
     */
    @Transactional(readOnly = true)
    public Optional<Worker> getWorkerById(Long id) {
        return workerRepository.findById(id);
    }
}
