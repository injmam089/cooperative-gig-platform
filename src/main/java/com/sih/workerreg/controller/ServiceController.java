package com.sih.workerreg.controller;

import com.sih.workerreg.model.ServiceItem;
import com.sih.workerreg.service.ServiceService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/services")
@CrossOrigin(origins = "*")
public class ServiceController {

    private final ServiceService serviceService;

    public ServiceController(ServiceService serviceService) {
        this.serviceService = serviceService;
    }

    /**
     * GET /api/services
     * Returns all active services stored in the MySQL database.
     */
    @GetMapping
    public ResponseEntity<List<ServiceItem>> getAllServices() {
        List<ServiceItem> services = serviceService.getAllServices();
        return ResponseEntity.ok(services);
    }

    /**
     * GET /api/services/{id}
     * Returns specific service details by ID.
     */
    @GetMapping("/{id}")
    public ResponseEntity<?> getServiceById(@PathVariable Long id) {
        return serviceService.getServiceById(id)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }
}
