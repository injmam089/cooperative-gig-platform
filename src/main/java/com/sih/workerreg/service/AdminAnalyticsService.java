package com.sih.workerreg.service;

import com.sih.workerreg.repository.CustomerRepository;
import com.sih.workerreg.repository.ServiceRepository;
import com.sih.workerreg.repository.ServiceRequestRepository;
import com.sih.workerreg.repository.WorkerRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class AdminAnalyticsService {

    private final CustomerRepository customerRepository;
    private final WorkerRepository workerRepository;
    private final ServiceRepository serviceRepository;
    private final ServiceRequestRepository serviceRequestRepository;

    public AdminAnalyticsService(CustomerRepository customerRepository,
                                 WorkerRepository workerRepository,
                                 ServiceRepository serviceRepository,
                                 ServiceRequestRepository serviceRequestRepository) {
        this.customerRepository = customerRepository;
        this.workerRepository = workerRepository;
        this.serviceRepository = serviceRepository;
        this.serviceRequestRepository = serviceRequestRepository;
    }

    @Transactional(readOnly = true)
    public Map<String, Object> getDashboardMetrics() {
        Map<String, Object> metrics = new LinkedHashMap<>();

        long totalCustomers = customerRepository.count();
        long totalWorkers = workerRepository.count();
        long totalServices = serviceRepository.count();
        long verifiedWorkers = workerRepository.countByStatus("VERIFIED");
        long totalBookings = serviceRequestRepository.count();
        long pendingRequests = serviceRequestRepository.countByStatus("PENDING");
        long activeServices = serviceRequestRepository.countByStatusIn(java.util.Arrays.asList("ACCEPTED", "ON_THE_WAY", "STARTED", "IN_PROGRESS"));
        long completedJobs = serviceRequestRepository.countByStatusIn(java.util.Arrays.asList("COMPLETED", "PAID", "RATED"));
        long openDisputes = serviceRequestRepository.countByDisputeStatus("OPEN");

        metrics.put("totalCustomers", totalCustomers);
        metrics.put("totalWorkers", totalWorkers);
        metrics.put("totalServices", totalServices);
        metrics.put("verifiedWorkers", verifiedWorkers);
        metrics.put("totalBookings", totalBookings);
        metrics.put("pendingRequests", pendingRequests);
        metrics.put("activeServices", activeServices);
        metrics.put("completedJobs", completedJobs);
        metrics.put("openDisputes", openDisputes);

        return metrics;
    }
}
