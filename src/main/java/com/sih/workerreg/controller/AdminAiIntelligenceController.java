package com.sih.workerreg.controller;

import com.sih.workerreg.model.Worker;
import com.sih.workerreg.repository.WorkerRepository;
import com.sih.workerreg.service.AiWorkforceIntelligenceService;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@CrossOrigin(originPatterns = "*", allowCredentials = "true")
public class AdminAiIntelligenceController {

    private final AiWorkforceIntelligenceService aiService;
    private final WorkerRepository workerRepository;

    public AdminAiIntelligenceController(AiWorkforceIntelligenceService aiService,
                                         WorkerRepository workerRepository) {
        this.aiService = aiService;
        this.workerRepository = workerRepository;
    }

    /**
     * GET /api/workforce/predictions
     * Dedicated REST API for AI Workforce Demand & Shortage Prediction.
     */
    @GetMapping("/api/workforce/predictions")
    public ResponseEntity<?> getWorkforcePredictions(
            @RequestParam(name = "location", required = false) String location,
            @RequestParam(name = "area", required = false) String area,
            @RequestParam(name = "time", required = false) String time,
            @RequestParam(name = "timeWindow", required = false) String timeWindow,
            @RequestParam(name = "mode", required = false, defaultValue = "LIVE_TELEMETRY") String mode) {

        String loc = (location != null && !location.trim().isEmpty()) ? location :
                     ((area != null && !area.trim().isEmpty()) ? area : "Aliganj");
        String t = (time != null && !time.trim().isEmpty()) ? time :
                   ((timeWindow != null && !timeWindow.trim().isEmpty()) ? timeWindow : "5:00 PM");

        Map<String, Object> predictions = aiService.getWorkforcePredictions(loc, t, mode);
        return ResponseEntity.ok(predictions);
    }

    /**
     * POST /api/workforce/activate-worker/{workerId}
     * Standby cooperative worker activation dispatch with administrative confirmation.
     */
    @PostMapping("/api/workforce/activate-worker/{workerId}")
    public ResponseEntity<?> activateCooperativeWorker(
            @PathVariable("workerId") Long workerId,
            @RequestBody(required = false) Map<String, String> body) {

        Optional<Worker> workerOpt = workerRepository.findById(workerId);
        if (workerOpt.isEmpty()) {
            Map<String, Object> err = new HashMap<>();
            err.put("success", false);
            err.put("message", "Worker #" + workerId + " not found.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(err);
        }

        Worker worker = workerOpt.get();
        String targetArea = body != null && body.containsKey("targetArea") ? body.get("targetArea") : "Aliganj, Lucknow";
        String message = String.format("Cooperative Dispatch Alert: High demand surge detected in %s. Please stay on active standby for prioritized doorstep bookings.", targetArea);

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("workerId", worker.getWorkerId());
        response.put("workerName", worker.getFullName());
        response.put("skill", worker.getSkill());
        response.put("status", "ACTIVATED_STANDBY");
        response.put("targetArea", targetArea);
        response.put("notificationMessage", message);
        response.put("actionTaken", "Cooperative Push Notification & SMS Dispatched to " + worker.getPhone());

        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/admin/ai/intelligence
     * Authenticated administrative endpoint for consolidated AI Workforce Intelligence.
     */
    @GetMapping("/api/admin/ai/intelligence")
    public ResponseEntity<?> getAdminWorkforceIntelligence(
            @RequestParam(name = "area", defaultValue = "All Areas") String area,
            @RequestParam(name = "timeWindow", defaultValue = "CURRENT") String timeWindow,
            @RequestParam(name = "mode", defaultValue = "LIVE_TELEMETRY") String mode,
            HttpSession session) {

        // Session authorization check
        if (session == null || (session.getAttribute("ADMIN_LOGGED_IN") == null && !"ADMIN".equals(session.getAttribute("ROLE")))) {
            Map<String, Object> err = new HashMap<>();
            err.put("success", false);
            err.put("message", "Access denied. Administrator privileges required.");
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(err);
        }

        Map<String, Object> intelligence = aiService.getWorkforceIntelligence(area, timeWindow, mode);
        return ResponseEntity.ok(intelligence);
    }

    /**
     * GET /api/ai/intelligence
     * Public platform / discovery endpoint for AI Workforce Intelligence.
     */
    @GetMapping("/api/ai/intelligence")
    public ResponseEntity<?> getPublicWorkforceIntelligence(
            @RequestParam(name = "area", defaultValue = "All Areas") String area,
            @RequestParam(name = "timeWindow", defaultValue = "CURRENT") String timeWindow,
            @RequestParam(name = "mode", defaultValue = "LIVE_TELEMETRY") String mode) {

        Map<String, Object> intelligence = aiService.getWorkforceIntelligence(area, timeWindow, mode);
        return ResponseEntity.ok(intelligence);
    }

    /**
     * POST /api/admin/ai/notify-worker/{workerId}
     * Dispatches a cooperative allocation notification to the worker.
     */
    @PostMapping("/api/admin/ai/notify-worker/{workerId}")
    public ResponseEntity<?> notifyWorkerForRebalance(
            @PathVariable("workerId") Long workerId,
            @RequestBody(required = false) Map<String, String> body,
            HttpSession session) {

        if (session == null || (session.getAttribute("ADMIN_LOGGED_IN") == null && !"ADMIN".equals(session.getAttribute("ROLE")))) {
            Map<String, Object> err = new HashMap<>();
            err.put("success", false);
            err.put("message", "Access denied. Administrator privileges required.");
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(err);
        }

        return activateCooperativeWorker(workerId, body);
    }
}
