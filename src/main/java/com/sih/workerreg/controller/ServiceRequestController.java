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
@RequestMapping("/api/service-requests")
@CrossOrigin(origins = "*")
public class ServiceRequestController {

    private final ServiceRequestService serviceRequestService;

    public ServiceRequestController(ServiceRequestService serviceRequestService) {
        this.serviceRequestService = serviceRequestService;
    }

    /**
     * POST /api/service-requests
     * Creates a new service booking linking the currently logged-in customer, worker, and service in MySQL.
     */
    @PostMapping
    public ResponseEntity<Map<String, Object>> createServiceRequest(@Valid @RequestBody CreateServiceRequestDto dto, HttpSession session) {
        Long customerId = session != null ? (Long) session.getAttribute("CUSTOMER_ID") : null;
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
}
