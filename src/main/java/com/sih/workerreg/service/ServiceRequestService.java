package com.sih.workerreg.service;

import com.sih.workerreg.dto.CreateServiceRequestDto;
import com.sih.workerreg.dto.ServiceRequestResponseDto;
import com.sih.workerreg.model.Customer;
import com.sih.workerreg.model.ServiceItem;
import com.sih.workerreg.model.ServiceRequest;
import com.sih.workerreg.model.Worker;
import com.sih.workerreg.repository.CustomerRepository;
import com.sih.workerreg.repository.ServiceRepository;
import com.sih.workerreg.repository.ServiceRequestRepository;
import com.sih.workerreg.repository.WorkerRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ServiceRequestService {

    private final ServiceRequestRepository serviceRequestRepository;
    private final CustomerRepository customerRepository;
    private final WorkerRepository workerRepository;
    private final ServiceRepository serviceRepository;
    private final NotificationService notificationService;

    public ServiceRequestService(ServiceRequestRepository serviceRequestRepository,
                                 CustomerRepository customerRepository,
                                 WorkerRepository workerRepository,
                                 ServiceRepository serviceRepository,
                                 NotificationService notificationService) {
        this.serviceRequestRepository = serviceRequestRepository;
        this.customerRepository = customerRepository;
        this.workerRepository = workerRepository;
        this.serviceRepository = serviceRepository;
        this.notificationService = notificationService;
    }

    /**
     * Creates and persists a new service request in MySQL with PENDING status for the given authenticated customerId.
     * Validates that worker's skill matches the requested service and prevents double-booking.
     */
    @Transactional
    public ServiceRequestResponseDto createServiceRequest(Long customerId, CreateServiceRequestDto dto) {
        if (customerId == null) {
            throw new IllegalArgumentException("Customer must be logged in to book a service.");
        }

        Customer customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new IllegalArgumentException("Customer not found with ID: " + customerId));

        Worker worker = workerRepository.findById(dto.getWorkerId())
                .orElseThrow(() -> new IllegalArgumentException("Worker not found with ID: " + dto.getWorkerId()));

        ServiceItem service = serviceRepository.findById(dto.getServiceId())
                .orElseThrow(() -> new IllegalArgumentException("Service not found with ID: " + dto.getServiceId()));

        // Validate skill match
        if (!isSkillMatching(worker.getSkill(), service.getServiceName())) {
            throw new IllegalArgumentException("Worker's skill (" + worker.getSkill() + ") does not match the requested service (" + service.getServiceName() + ").");
        }

        // Parse date and time
        LocalDate preferredDate = parseDate(dto.getPreferredDate());
        String preferredTime = (dto.getPreferredTime() != null && !dto.getPreferredTime().trim().isEmpty())
                ? dto.getPreferredTime().trim()
                : "Morning (9:00 AM - 12:00 PM)";

        // Check for double booking
        boolean alreadyBooked = serviceRequestRepository.existsByWorkerWorkerIdAndPreferredDateAndPreferredTimeAndStatusNotIn(
                worker.getWorkerId(), preferredDate, preferredTime, Arrays.asList("REJECTED", "CANCELLED")
        );
        if (alreadyBooked) {
            throw new IllegalArgumentException("Worker " + worker.getFullName() + " is already booked on " + preferredDate + " at " + preferredTime + ". Please choose a different date or time slot.");
        }

        ServiceRequest request = new ServiceRequest();
        request.setCustomer(customer);
        request.setWorker(worker);
        request.setService(service);
        request.setDescription(dto.getDescription().trim());
        request.setLocation(dto.getLocation().trim());
        request.setPreferredDate(preferredDate);
        request.setPreferredTime(preferredTime);
        request.setStatus("PENDING");
        request.setDisputeStatus("NONE");

        ServiceRequest saved = serviceRequestRepository.save(request);

        // Transactional Notifications
        try {
            notificationService.createNotification(
                    "WORKER", worker.getWorkerId(),
                    "New Service Request Assigned",
                    "Customer " + customer.getFullName() + " requested " + service.getServiceName() + " on " + preferredDate + " (" + preferredTime + ").",
                    "BOOKING", saved.getRequestId()
            );
            notificationService.createNotification(
                    "CUSTOMER", customer.getCustomerId(),
                    "Service Request Submitted",
                    "Your booking for " + service.getServiceName() + " with " + worker.getFullName() + " has been placed successfully.",
                    "BOOKING", saved.getRequestId()
            );
        } catch (Exception ignored) {}

        return new ServiceRequestResponseDto(saved);
    }

    @Transactional(readOnly = true)
    public List<ServiceRequestResponseDto> getAllRequests() {
        try {
            return serviceRequestRepository.findAllByOrderByCreatedAtDesc()
                    .stream()
                    .map(ServiceRequestResponseDto::new)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            return serviceRequestRepository.findAll()
                    .stream()
                    .map(ServiceRequestResponseDto::new)
                    .collect(Collectors.toList());
        }
    }

    @Transactional(readOnly = true)
    public Optional<ServiceRequestResponseDto> getRequestById(Long id) {
        return serviceRequestRepository.findById(id).map(ServiceRequestResponseDto::new);
    }

    /**
     * Updates the status of an existing service request with rigorous server-side lifecycle validation:
     * PENDING -> ASSIGNED -> ACCEPTED -> ON_THE_WAY -> STARTED -> COMPLETED -> PAID -> RATED
     * Alternative states: CANCELLED, REJECTED, DISPUTED
     */
    @Transactional
    public ServiceRequestResponseDto updateRequestStatus(Long id, String status, Long authenticatedWorkerId) {
        ServiceRequest request = serviceRequestRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Service request not found with ID: " + id));

        // Validate assigned worker if workerId is provided
        if (authenticatedWorkerId != null && request.getWorker() != null && !request.getWorker().getWorkerId().equals(authenticatedWorkerId)) {
            throw new IllegalArgumentException("Unauthorized: You can only update service requests assigned to you.");
        }

        if (status == null || status.trim().isEmpty()) {
            throw new IllegalArgumentException("Status is required.");
        }

        String targetStatus = status.trim().toUpperCase();
        String currentStatus = request.getStatus() != null ? request.getStatus().trim().toUpperCase() : "PENDING";

        // Validate allowed workflow transitions
        if ("ACCEPTED".equals(targetStatus)) {
            if (!"PENDING".equals(currentStatus) && !"ASSIGNED".equals(currentStatus) && !"REQUESTED".equals(currentStatus)) {
                throw new IllegalArgumentException("Cannot accept request with status " + currentStatus + ". Only PENDING or ASSIGNED requests can be ACCEPTED.");
            }
            request.setAcceptedAt(java.time.LocalDateTime.now());
        } else if ("REJECTED".equals(targetStatus)) {
            if (!"PENDING".equals(currentStatus) && !"ASSIGNED".equals(currentStatus) && !"REQUESTED".equals(currentStatus)) {
                throw new IllegalArgumentException("Cannot reject request with status " + currentStatus + ".");
            }
        } else if ("ON_THE_WAY".equals(targetStatus)) {
            if (!"ACCEPTED".equals(currentStatus)) {
                throw new IllegalArgumentException("Artisan must ACCEPT the booking before marking status as ON_THE_WAY.");
            }
        } else if ("STARTED".equals(targetStatus) || "IN_PROGRESS".equals(targetStatus)) {
            if (!"ACCEPTED".equals(currentStatus) && !"ON_THE_WAY".equals(currentStatus)) {
                throw new IllegalArgumentException("Cannot start job directly from status " + currentStatus + ".");
            }
            request.setStartedAt(java.time.LocalDateTime.now());
        } else if ("COMPLETED".equals(targetStatus)) {
            if (!"ACCEPTED".equals(currentStatus) && !"ON_THE_WAY".equals(currentStatus) && !"STARTED".equals(currentStatus) && !"IN_PROGRESS".equals(currentStatus)) {
                throw new IllegalArgumentException("Cannot complete request with status " + currentStatus + ".");
            }
            request.setCompletedAt(java.time.LocalDateTime.now());
            // Increment worker completed jobs
            if (request.getWorker() != null) {
                Worker w = request.getWorker();
                w.setCompletedJobsCount((w.getCompletedJobsCount() != null ? w.getCompletedJobsCount() : 0) + 1);
                workerRepository.save(w);
            }
        } else if ("PAID".equals(targetStatus)) {
            if (!"COMPLETED".equals(currentStatus) && !"RATED".equals(currentStatus)) {
                throw new IllegalArgumentException("Cannot mark as PAID before service is COMPLETED.");
            }
        } else if ("CANCELLED".equals(targetStatus)) {
            if ("COMPLETED".equals(currentStatus) || "PAID".equals(currentStatus) || "RATED".equals(currentStatus)) {
                throw new IllegalArgumentException("Cannot cancel an already completed or settled booking.");
            }
        }

        request.setStatus(targetStatus);
        ServiceRequest updated = serviceRequestRepository.save(request);

        // Transactional Notifications
        try {
            if (request.getCustomer() != null) {
                String notifMsg = switch (targetStatus) {
                    case "ACCEPTED" -> "Artisan " + request.getWorker().getFullName() + " has accepted your service request.";
                    case "ON_THE_WAY" -> "Artisan " + request.getWorker().getFullName() + " is on the way to your location.";
                    case "STARTED", "IN_PROGRESS" -> "Service for " + request.getService().getServiceName() + " has started.";
                    case "COMPLETED" -> "Service completed! Please inspect the work and rate your artisan.";
                    case "REJECTED" -> "Your booking could not be accepted at this time. Please choose another artisan.";
                    default -> "Booking #" + request.getRequestId() + " updated to " + targetStatus;
                };
                notificationService.createNotification("CUSTOMER", request.getCustomer().getCustomerId(), "Booking Status: " + targetStatus, notifMsg, "BOOKING", request.getRequestId());
            }
        } catch (Exception ignored) {}

        return new ServiceRequestResponseDto(updated);
    }

    /**
     * Customer rates and reviews the completed service.
     */
    @Transactional
    public ServiceRequestResponseDto rateServiceRequest(Long id, Double rating, String reviewNotes, Long authenticatedCustomerId) {
        ServiceRequest request = serviceRequestRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Service request not found with ID: " + id));

        if (authenticatedCustomerId != null && request.getCustomer() != null && !request.getCustomer().getCustomerId().equals(authenticatedCustomerId)) {
            throw new IllegalArgumentException("Unauthorized: You can only rate your own bookings.");
        }

        if (rating == null || rating < 1.0 || rating > 5.0) {
            throw new IllegalArgumentException("Rating must be between 1.0 and 5.0.");
        }

        request.setRating(rating);
        request.setReviewNotes(reviewNotes != null ? reviewNotes.trim() : "");
        if ("COMPLETED".equalsIgnoreCase(request.getStatus()) || "PAID".equalsIgnoreCase(request.getStatus())) {
            request.setStatus("RATED");
        }

        // Recalculate worker rating
        if (request.getWorker() != null) {
            Worker w = request.getWorker();
            int prevTotal = w.getTotalRatings() != null ? w.getTotalRatings() : 10;
            double prevAvg = w.getAverageRating() != null ? w.getAverageRating() : 4.8;
            double newAvg = ((prevAvg * prevTotal) + rating) / (prevTotal + 1);
            w.setTotalRatings(prevTotal + 1);
            w.setAverageRating(Math.round(newAvg * 10.0) / 10.0);
            workerRepository.save(w);

            try {
                notificationService.createNotification(
                        "WORKER", w.getWorkerId(),
                        "New Customer Rating Received",
                        "Customer rated your service " + rating + " ⭐: \"" + (reviewNotes != null ? reviewNotes : "Great service!") + "\"",
                        "BOOKING", request.getRequestId()
                );
            } catch (Exception ignored) {}
        }

        ServiceRequest saved = serviceRequestRepository.save(request);
        return new ServiceRequestResponseDto(saved);
    }

    /**
     * Customer or Worker reports a dispute on a service.
     */
    @Transactional
    public ServiceRequestResponseDto raiseDispute(Long id, String reason, Long reporterId, String reporterRole) {
        ServiceRequest request = serviceRequestRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Service request not found with ID: " + id));

        if (reason == null || reason.trim().isEmpty()) {
            throw new IllegalArgumentException("Dispute reason is required.");
        }

        request.setDisputeReason(reason.trim());
        request.setDisputeStatus("OPEN");
        ServiceRequest saved = serviceRequestRepository.save(request);

        try {
            notificationService.createNotification(
                    "ADMIN", null,
                    "New Dispute Raised (Booking #" + id + ")",
                    "Dispute reported by " + reporterRole + ": " + reason.trim(),
                    "DISPUTE", id
            );
        } catch (Exception ignored) {}

        return new ServiceRequestResponseDto(saved);
    }

    /**
     * Admin resolves a dispute on a service.
     */
    @Transactional
    public ServiceRequestResponseDto resolveDispute(Long id, String resolution, String newStatus) {
        ServiceRequest request = serviceRequestRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Service request not found with ID: " + id));

        request.setDisputeResolution(resolution != null ? resolution.trim() : "Resolved by Admin");
        request.setDisputeStatus(newStatus != null ? newStatus.toUpperCase() : "RESOLVED");
        ServiceRequest saved = serviceRequestRepository.save(request);

        try {
            if (request.getCustomer() != null) {
                notificationService.createNotification(
                        "CUSTOMER", request.getCustomer().getCustomerId(),
                        "Dispute Resolved (Booking #" + id + ")",
                        "Admin resolution: " + request.getDisputeResolution(),
                        "DISPUTE", id
                );
            }
            if (request.getWorker() != null) {
                notificationService.createNotification(
                        "WORKER", request.getWorker().getWorkerId(),
                        "Dispute Resolved (Booking #" + id + ")",
                        "Admin resolution: " + request.getDisputeResolution(),
                        "DISPUTE", id
                );
            }
        } catch (Exception ignored) {}

        return new ServiceRequestResponseDto(saved);
    }

    /**
     * Validates whether a worker's registered skill corresponds to the requested service category.
     */
    public boolean isSkillMatching(String workerSkill, String serviceName) {
        if (workerSkill == null || serviceName == null) return false;
        String w = workerSkill.trim().toLowerCase();
        String s = serviceName.trim().toLowerCase();
        if (w.equals(s) || w.contains(s) || s.contains(w)) return true;

        if ((w.contains("plumb") && s.contains("plumb")) ||
            ((w.contains("electr") || w.contains("wire")) && (s.contains("electr") || s.contains("wire"))) ||
            ((w.contains("carpent") || w.contains("wood")) && (s.contains("carpent") || s.contains("wood"))) ||
            ((w.contains("paint")) && (s.contains("paint"))) ||
            ((w.contains("clean")) && (s.contains("clean"))) ||
            ((w.contains("ac") || w.contains("air") || w.contains("appliance")) && (s.contains("ac") || s.contains("air") || s.contains("appliance"))) ||
            ((w.contains("driv") || w.contains("chauffeur")) && (s.contains("driv") || s.contains("chauffeur"))) ||
            ((w.contains("cook") || w.contains("chef")) && (s.contains("cook") || s.contains("chef"))) ||
            ((w.contains("mason") || w.contains("construct") || w.contains("brick")) && (s.contains("mason") || s.contains("construct") || s.contains("brick"))) ||
            ((w.contains("laund") || w.contains("wash")) && (s.contains("laund") || s.contains("wash")))) {
            return true;
        }
        return false;
    }

    private LocalDate parseDate(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            return LocalDate.now().plusDays(1);
        }
        try {
            return LocalDate.parse(dateStr.trim());
        } catch (Exception e) {
            String lower = dateStr.trim().toLowerCase();
            if (lower.contains("today")) return LocalDate.now();
            if (lower.contains("tomorrow")) return LocalDate.now().plusDays(1);
            return LocalDate.now().plusDays(1);
        }
    }

    private LocalTime parseTime(String timeStr) {
        if (timeStr == null || timeStr.trim().isEmpty()) {
            return LocalTime.of(10, 0);
        }
        try {
            String clean = timeStr.trim();
            if (clean.length() == 5) return LocalTime.parse(clean);
            if (clean.length() == 8) return LocalTime.parse(clean);
            String lower = clean.toLowerCase();
            if (lower.contains("morning")) return LocalTime.of(10, 0);
            if (lower.contains("afternoon")) return LocalTime.of(14, 0);
            if (lower.contains("evening")) return LocalTime.of(18, 0);
            return LocalTime.of(10, 0);
        } catch (Exception e) {
            return LocalTime.of(10, 0);
        }
    }
}
