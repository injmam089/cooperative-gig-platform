package com.sih.workerreg.controller;

import com.sih.workerreg.service.AdminAnalyticsService;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/admin")
@CrossOrigin(originPatterns = "*", allowCredentials = "true")
public class AdminAnalyticsController {

    private final AdminAnalyticsService analyticsService;
    private final com.sih.workerreg.repository.WorkerRepository workerRepository;
    private final com.sih.workerreg.repository.ServiceRequestRepository serviceRequestRepository;

    public AdminAnalyticsController(AdminAnalyticsService analyticsService,
                                  com.sih.workerreg.repository.WorkerRepository workerRepository,
                                  com.sih.workerreg.repository.ServiceRequestRepository serviceRequestRepository) {
        this.analyticsService = analyticsService;
        this.workerRepository = workerRepository;
        this.serviceRequestRepository = serviceRequestRepository;
    }

    /**
     * POST /api/admin/login
     * Authenticates administrative session.
     */
    @PostMapping("/login")
    public ResponseEntity<?> adminLogin(@RequestBody Map<String, String> credentials, HttpSession session) {
        String username = credentials.get("username") != null ? credentials.get("username") : credentials.get("email");
        String password = credentials.get("password");

        if (("admin".equalsIgnoreCase(username) || "admin@sih.gov.in".equalsIgnoreCase(username)) 
                && "Admin@123".equals(password)) {
            if (session != null) {
                session.setAttribute("ADMIN_LOGGED_IN", true);
                session.setAttribute("ROLE", "ADMIN");
            }
            Map<String, Object> res = new HashMap<>();
            res.put("success", true);
            res.put("message", "Admin logged in successfully!");
            res.put("role", "ADMIN");
            return ResponseEntity.ok(res);
        }

        Map<String, Object> err = new HashMap<>();
        err.put("success", false);
        err.put("message", "Invalid admin credentials.");
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(err);
    }

    /**
     * POST /api/admin/logout
     */
    @PostMapping("/logout")
    public ResponseEntity<?> adminLogout(HttpSession session) {
        if (session != null) {
            session.removeAttribute("ADMIN_LOGGED_IN");
            session.removeAttribute("ROLE");
        }
        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        res.put("message", "Admin logged out successfully.");
        return ResponseEntity.ok(res);
    }

    /**
     * GET /api/admin/dashboard
     * Returns live aggregated database counts from MySQL.
     */
    @GetMapping("/dashboard")
    public ResponseEntity<Map<String, Object>> getDashboard() {
        return ResponseEntity.ok(analyticsService.getDashboardMetrics());
    }

    /**
     * PATCH /api/admin/workers/{id}/verify
     * Admin approves or revokes worker cooperative verification status.
     */
    @PatchMapping("/workers/{id}/verify")
    public ResponseEntity<Map<String, Object>> verifyWorker(
            @PathVariable Long id,
            @RequestBody Map<String, String> body) {
        String status = body.get("status") != null ? body.get("status").trim().toUpperCase() : "VERIFIED";
        return workerRepository.findById(id).map(w -> {
            w.setStatus(status);
            if (body.containsKey("notes")) {
                w.setVerificationNotes(body.get("notes"));
            }
            workerRepository.save(w);
            Map<String, Object> res = new HashMap<>();
            res.put("success", true);
            res.put("message", "Worker status updated to " + status);
            res.put("workerId", id);
            res.put("status", status);
            return ResponseEntity.ok(res);
        }).orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    /**
     * GET /api/admin/complaints
     * Lists all service requests with active or resolved disputes.
     */
    @GetMapping("/complaints")
    public ResponseEntity<java.util.List<com.sih.workerreg.dto.ServiceRequestResponseDto>> getComplaints() {
        java.util.List<com.sih.workerreg.dto.ServiceRequestResponseDto> complaints = serviceRequestRepository
                .findByDisputeStatusNot("NONE")
                .stream()
                .map(com.sih.workerreg.dto.ServiceRequestResponseDto::new)
                .toList();
        return ResponseEntity.ok(complaints);
    }
}

