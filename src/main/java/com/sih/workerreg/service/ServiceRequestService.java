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

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ServiceRequestService {

    private final ServiceRequestRepository serviceRequestRepository;
    private final CustomerRepository customerRepository;
    private final WorkerRepository workerRepository;
    private final ServiceRepository serviceRepository;

    public ServiceRequestService(ServiceRequestRepository serviceRequestRepository,
                                 CustomerRepository customerRepository,
                                 WorkerRepository workerRepository,
                                 ServiceRepository serviceRepository) {
        this.serviceRequestRepository = serviceRequestRepository;
        this.customerRepository = customerRepository;
        this.workerRepository = workerRepository;
        this.serviceRepository = serviceRepository;
    }

    /**
     * Creates and persists a new service request in MySQL with PENDING status for the given authenticated customerId.
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

        ServiceRequest request = new ServiceRequest();
        request.setCustomer(customer);
        request.setWorker(worker);
        request.setService(service);
        request.setDescription(dto.getDescription().trim());
        request.setLocation(dto.getLocation().trim());
        request.setPreferredDate(dto.getPreferredDate().trim());
        request.setPreferredTime(dto.getPreferredTime().trim());
        request.setStatus("PENDING");

        ServiceRequest saved = serviceRequestRepository.save(request);
        return new ServiceRequestResponseDto(saved);
    }


    @Transactional(readOnly = true)
    public List<ServiceRequestResponseDto> getAllRequests() {
        return serviceRequestRepository.findAllByOrderByCreatedAtDesc()
                .stream()
                .map(ServiceRequestResponseDto::new)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public Optional<ServiceRequestResponseDto> getRequestById(Long id) {
        return serviceRequestRepository.findById(id).map(ServiceRequestResponseDto::new);
    }
}
