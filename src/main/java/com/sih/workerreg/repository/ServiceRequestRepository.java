package com.sih.workerreg.repository;

import com.sih.workerreg.model.ServiceRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ServiceRequestRepository extends JpaRepository<ServiceRequest, Long> {

    List<ServiceRequest> findAllByOrderByCreatedAtDesc();

    List<ServiceRequest> findByCustomerCustomerIdOrderByCreatedAtDesc(Long customerId);

    List<ServiceRequest> findByWorkerWorkerIdOrderByCreatedAtDesc(Long workerId);
}
