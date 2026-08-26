package com.sih.workerreg.service;

import com.sih.workerreg.model.ServiceItem;
import com.sih.workerreg.repository.ServiceRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class ServiceService {

    private final ServiceRepository serviceRepository;

    public ServiceService(ServiceRepository serviceRepository) {
        this.serviceRepository = serviceRepository;
    }

    @Transactional(readOnly = true)
    public List<ServiceItem> getAllServices() {
        return serviceRepository.findAllByOrderByServiceIdAsc();
    }

    @Transactional(readOnly = true)
    public Optional<ServiceItem> getServiceById(Long id) {
        return serviceRepository.findById(id);
    }
}
