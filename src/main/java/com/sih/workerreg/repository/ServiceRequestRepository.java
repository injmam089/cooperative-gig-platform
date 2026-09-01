package com.sih.workerreg.repository;

import com.sih.workerreg.model.ServiceRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Repository
public interface ServiceRequestRepository extends JpaRepository<ServiceRequest, Long> {

    List<ServiceRequest> findAllByOrderByCreatedAtDesc();

    List<ServiceRequest> findAllByOrderByRequestIdDesc();

    List<ServiceRequest> findByCustomerCustomerIdOrderByCreatedAtDesc(Long customerId);

    List<ServiceRequest> findByWorkerWorkerIdOrderByCreatedAtDesc(Long workerId);

    List<ServiceRequest> findByLocationContainingIgnoreCase(String location);

    List<ServiceRequest> findByServiceServiceNameContainingIgnoreCase(String serviceName);

    boolean existsByWorkerWorkerIdAndPreferredDateAndPreferredTimeAndStatusNotIn(
            Long workerId, LocalDate preferredDate, String preferredTime, List<String> excludedStatuses
    );

    long countByStatus(String status);

    long countByStatusIn(List<String> statuses);

    long countByDisputeStatus(String disputeStatus);

    List<ServiceRequest> findByDisputeStatusNot(String disputeStatus);
}

