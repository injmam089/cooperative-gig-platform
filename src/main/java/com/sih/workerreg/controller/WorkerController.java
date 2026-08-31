package com.sih.workerreg.controller;

import com.sih.workerreg.dto.WorkerLoginDto;
import com.sih.workerreg.dto.WorkerRegistrationDto;
import com.sih.workerreg.model.Customer;
import com.sih.workerreg.model.Worker;
import com.sih.workerreg.repository.CustomerRepository;
import com.sih.workerreg.service.WorkerService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/workers")
@CrossOrigin(originPatterns = "*", allowCredentials = "true")
public class WorkerController {

    private final WorkerService workerService;
    private final CustomerRepository customerRepository;
    private final com.sih.workerreg.repository.WorkerRepository workerRepository;

    public WorkerController(WorkerService workerService, CustomerRepository customerRepository, com.sih.workerreg.repository.WorkerRepository workerRepository) {
        this.workerService = workerService;
        this.customerRepository = customerRepository;
        this.workerRepository = workerRepository;
    }

    /**
     * POST /api/workers
     * Receives registration form payload, validates it, and persists into MySQL.
     */
    @PostMapping
    public ResponseEntity<Map<String, Object>> registerWorker(@Valid @RequestBody WorkerRegistrationDto registrationDto, HttpSession session) {
        Worker savedWorker = workerService.registerWorker(registrationDto);

        if (session != null) {
            session.setAttribute("WORKER_ID", savedWorker.getWorkerId());
        }

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Worker registered successfully in MySQL database!");
        response.put("workerId", savedWorker.getWorkerId());
        response.put("data", savedWorker);

        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    /**
     * POST /api/workers/login
     * Authenticates worker credentials and establishes session.
     */
    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> loginWorker(@Valid @RequestBody WorkerLoginDto dto, HttpSession session) {
        Worker worker = workerService.authenticate(dto.getEmail(), dto.getPassword());

        if (session != null) {
            session.setAttribute("WORKER_ID", worker.getWorkerId());
        }

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Worker logged in successfully!");
        response.put("workerId", worker.getWorkerId());
        response.put("data", worker);

        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/workers/me
     * Returns currently authenticated worker's details.
     */
    @GetMapping("/me")
    public ResponseEntity<?> getCurrentWorker(HttpSession session) {
        Long workerId = session != null ? (Long) session.getAttribute("WORKER_ID") : null;
        if (workerId == null) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "Unauthorized. No worker is currently logged in.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(error);
        }

        Optional<Worker> workerOpt = workerService.getWorkerById(workerId);
        if (workerOpt.isPresent()) {
            return ResponseEntity.ok(workerOpt.get());
        }

        if (session != null) {
            session.removeAttribute("WORKER_ID");
        }
        Map<String, Object> error = new HashMap<>();
        error.put("success", false);
        error.put("message", "Worker account not found.");
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(error);
    }

    /**
     * POST /api/workers/logout
     * Clears worker session.
     */
    @PostMapping("/logout")
    public ResponseEntity<Map<String, Object>> logoutWorker(HttpSession session) {
        if (session != null) {
            session.removeAttribute("WORKER_ID");
        }
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Worker logged out successfully.");
        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/workers/nearby?city=Lucknow
     * Strictly filters workers to the specified city or the authenticated customer's profile city.
     * Guaranteed to exclude workers from other cities.
     */
    @GetMapping("/nearby")
    public ResponseEntity<?> getNearbyWorkers(
            @RequestParam(required = false) String city,
            @RequestParam(required = false) String skill,
            @RequestParam(required = false) String status,
            HttpSession session) {

        String resolvedCity = city;

        // Fallback: If city query parameter is omitted, inspect session for logged-in customer
        if ((resolvedCity == null || resolvedCity.trim().isEmpty()) && session != null) {
            Long customerId = (Long) session.getAttribute("CUSTOMER_ID");
            if (customerId != null) {
                Optional<Customer> customerOpt = customerRepository.findById(customerId);
                if (customerOpt.isPresent()) {
                    resolvedCity = customerOpt.get().getLocation();
                }
            }
        }

        // If city is missing/null/blank, do not return random cross-city workers
        if (resolvedCity == null || resolvedCity.trim().isEmpty()) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "A valid city is required to find nearby verified workers.");
            error.put("workers", List.of());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(error);
        }

        List<Worker> workers = workerService.getNearbyWorkers(resolvedCity, skill, status);
        return ResponseEntity.ok(workers);
    }

    /**
     * GET /api/workers or GET /api/workers?skill=Plumbing or GET /api/workers?city=Lucknow
     * Returns all registered workers, or filters by skill/city if parameters are provided.
     */
    @GetMapping
    public ResponseEntity<List<Worker>> getWorkers(
            @RequestParam(required = false) String skill,
            @RequestParam(required = false) String city,
            @RequestParam(required = false) String status) {
        List<Worker> workers;
        if (city != null && !city.trim().isEmpty()) {
            workers = workerService.getNearbyWorkers(city, skill, status);
        } else if (skill != null && !skill.trim().isEmpty()) {
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
                .map(w -> {
                    w.setPassword(null);
                    return ResponseEntity.ok(w);
                })
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    /**
     * PUT /api/workers/{id}/availability
     * Worker updates their live availability state (AVAILABLE, BUSY, OFFLINE).
     */
    @PutMapping("/{id}/availability")
    public ResponseEntity<Map<String, Object>> updateWorkerAvailability(
            @PathVariable Long id,
            @RequestBody Map<String, String> body,
            HttpSession session) {
        String availability = body.get("availability");
        if (availability == null || availability.trim().isEmpty()) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "Availability state is required (AVAILABLE, BUSY, OFFLINE).");
            return ResponseEntity.badRequest().body(error);
        }

        Optional<Worker> workerOpt = workerService.getWorkerById(id);
        if (workerOpt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        Worker worker = workerOpt.get();
        worker.setCurrentAvailability(availability.trim().toUpperCase());
        workerRepository.save(worker);

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Availability updated to " + worker.getCurrentAvailability());
        response.put("availability", worker.getCurrentAvailability());
        return ResponseEntity.ok(response);
    }

    /**
     * PUT /api/workers/{id}/schedule
     * Worker configures their weekly schedule and shift hours.
     */
    @PutMapping("/{id}/schedule")
    public ResponseEntity<Map<String, Object>> updateWorkerSchedule(
            @PathVariable Long id,
            @RequestBody Map<String, String> body) {
        Optional<Worker> workerOpt = workerService.getWorkerById(id);
        if (workerOpt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        Worker worker = workerOpt.get();
        if (body.containsKey("workingDays")) worker.setWorkingDays(body.get("workingDays"));
        if (body.containsKey("shiftStartTime")) worker.setShiftStartTime(body.get("shiftStartTime"));
        if (body.containsKey("shiftEndTime")) worker.setShiftEndTime(body.get("shiftEndTime"));
        workerRepository.save(worker);

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Working schedule updated successfully.");
        response.put("workingDays", worker.getWorkingDays());
        response.put("shiftStartTime", worker.getShiftStartTime());
        response.put("shiftEndTime", worker.getShiftEndTime());
        return ResponseEntity.ok(response);
    }
}

