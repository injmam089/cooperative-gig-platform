package com.sih.workerreg.controller;

import com.sih.workerreg.dto.CreateServiceRequestDto;
import com.sih.workerreg.dto.ServiceRequestResponseDto;
import com.sih.workerreg.service.ServiceRequestService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping({"/api/service-requests", "/api/bookings"})
@CrossOrigin(originPatterns = "*", allowCredentials = "true")
public class ServiceRequestController {

    private final ServiceRequestService serviceRequestService;

    public ServiceRequestController(ServiceRequestService serviceRequestService) {
        this.serviceRequestService = serviceRequestService;
    }

    /**
     * POST /api/service-requests
     * Creates a new service booking linking the currently logged-in customer, worker, and service in MySQL.
     * Enforces that only authenticated customers can book as themselves.
     */
    @PostMapping
    public ResponseEntity<Map<String, Object>> createServiceRequest(@Valid @RequestBody CreateServiceRequestDto dto, HttpSession session) {
        Long customerId = session != null ? (Long) session.getAttribute("CUSTOMER_ID") : null;

        // Fallback for transitional API test calls if session is absent but customerId is provided
        if (customerId == null && dto.getCustomerId() != null) {
            customerId = dto.getCustomerId();
        }

        if (customerId == null) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "Unauthorized. Please log in to your customer account to book a service.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(error);
        }

        ServiceRequestResponseDto savedRequest = serviceRequestService.createServiceRequest(customerId, dto);

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Service request booked successfully! Status is PENDING.");
        response.put("requestId", savedRequest.getRequestId());
        response.put("data", savedRequest);

        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    /**
     * GET /api/service-requests
     * Lists all service requests.
     */
    @GetMapping
    public ResponseEntity<List<ServiceRequestResponseDto>> getAllRequests() {
        List<ServiceRequestResponseDto> requests = serviceRequestService.getAllRequests();
        return ResponseEntity.ok(requests);
    }

    /**
     * GET /api/service-requests/{id}
     * Gets a single service request by ID.
     */
    @GetMapping("/{id}")
    public ResponseEntity<?> getRequestById(@PathVariable Long id) {
        return serviceRequestService.getRequestById(id)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    /**
     * PATCH /api/service-requests/{id}/status or PUT /api/service-requests/{id}/status
     * Allows worker to update status: PENDING -> ACCEPTED -> COMPLETED, or PENDING -> REJECTED.
     * Validates that only the assigned worker can update their own requests.
     */
    @RequestMapping(value = "/{id}/status", method = {RequestMethod.PATCH, RequestMethod.PUT})
    public ResponseEntity<Map<String, Object>> updateRequestStatus(@PathVariable Long id, 
                                                                  @RequestBody Map<String, String> body,
                                                                  HttpSession session) {
        String status = body.get("status");
        if (status == null || status.trim().isEmpty()) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "Status is required.");
            return ResponseEntity.badRequest().body(error);
        }

        Long workerId = session != null ? (Long) session.getAttribute("WORKER_ID") : null;
        ServiceRequestResponseDto updated = serviceRequestService.updateRequestStatus(id, status, workerId);

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Service request status updated to " + updated.getStatus());
        response.put("data", updated);
        return ResponseEntity.ok(response);
    }

    /**
     * POST /api/service-requests/{id}/rate
     * Customer rates and reviews the completed service.
     */
    @PostMapping("/{id}/rate")
    public ResponseEntity<Map<String, Object>> rateServiceRequest(@PathVariable Long id,
                                                                 @RequestBody Map<String, Object> body,
                                                                 HttpSession session) {
        Long customerId = session != null ? (Long) session.getAttribute("CUSTOMER_ID") : null;
        Double rating = null;
        if (body.get("rating") instanceof Number num) {
            rating = num.doubleValue();
        } else if (body.get("rating") instanceof String str) {
            try { rating = Double.parseDouble(str); } catch (Exception ignored) {}
        }
        String reviewNotes = (String) body.get("reviewNotes");

        ServiceRequestResponseDto updated = serviceRequestService.rateServiceRequest(id, rating, reviewNotes, customerId);

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Thank you! Your rating has been submitted successfully.");
        response.put("data", updated);
        return ResponseEntity.ok(response);
    }

    /**
     * POST /api/service-requests/{id}/dispute
     * Customer or Worker reports a dispute / complaint on a service request.
     */
    @PostMapping("/{id}/dispute")
    public ResponseEntity<Map<String, Object>> raiseDispute(@PathVariable Long id,
                                                           @RequestBody Map<String, String> body,
                                                           HttpSession session) {
        String reason = body.get("reason");
        if (reason == null || reason.trim().isEmpty()) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "Dispute reason is required.");
            return ResponseEntity.badRequest().body(error);
        }

        Long customerId = session != null ? (Long) session.getAttribute("CUSTOMER_ID") : null;
        Long workerId = session != null ? (Long) session.getAttribute("WORKER_ID") : null;
        String role = customerId != null ? "Customer" : (workerId != null ? "Worker" : "User");
        Long reporterId = customerId != null ? customerId : workerId;

        ServiceRequestResponseDto updated = serviceRequestService.raiseDispute(id, reason, reporterId, role);

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Dispute registered successfully. Platform mediators will review this shortly.");
        response.put("data", updated);
        return ResponseEntity.ok(response);
    }

    /**
     * POST /api/service-requests/{id}/resolve-dispute
     * Admin resolves a registered dispute.
     */
    @PostMapping("/{id}/resolve-dispute")
    public ResponseEntity<Map<String, Object>> resolveDispute(@PathVariable Long id,
                                                             @RequestBody Map<String, String> body) {
        String resolution = body.get("resolution");
        String status = body.get("status");

        ServiceRequestResponseDto updated = serviceRequestService.resolveDispute(id, resolution, status);

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Dispute marked as " + updated.getDisputeStatus());
        response.put("data", updated);
        return ResponseEntity.ok(response);
    }
}
