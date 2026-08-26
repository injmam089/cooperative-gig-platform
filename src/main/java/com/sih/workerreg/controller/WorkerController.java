package com.sih.workerreg.controller;

import com.sih.workerreg.dto.WorkerRegistrationDto;
import com.sih.workerreg.model.Worker;
import com.sih.workerreg.service.WorkerService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/workers")
@CrossOrigin(origins = "*") // Allows API calls from any origin/port
public class WorkerController {

    private final WorkerService workerService;

    public WorkerController(WorkerService workerService) {
        this.workerService = workerService;
    }

    /**
     * POST /api/workers
     * Receives registration form payload, validates it, and persists into MySQL.
     */
    @PostMapping
    public ResponseEntity<Map<String, Object>> registerWorker(@Valid @RequestBody WorkerRegistrationDto registrationDto) {
        Worker savedWorker = workerService.registerWorker(registrationDto);

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Worker registered successfully in MySQL database!");
        response.put("workerId", savedWorker.getWorkerId());
        response.put("data", savedWorker);

        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    /**
     * GET /api/workers or GET /api/workers?skill=Plumbing
     * Returns all registered workers, or filters by skill if the parameter is provided.
     */
    @GetMapping
    public ResponseEntity<List<Worker>> getWorkers(@RequestParam(required = false) String skill) {
        List<Worker> workers;
        if (skill != null && !skill.trim().isEmpty()) {
            workers = workerService.searchWorkersBySkill(skill);
        } else {
            workers = workerService.getAllWorkers();
        }
        return ResponseEntity.ok(workers);
    }

    /**
     * GET /api/workers/{id}
     * Returns a specific worker by ID.
     */
    @GetMapping("/{id}")
    public ResponseEntity<?> getWorkerById(@PathVariable Long id) {
        return workerService.getWorkerById(id)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }
}
