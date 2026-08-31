package com.sih.workerreg.repository;

import com.sih.workerreg.model.ServiceItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ServiceRepository extends JpaRepository<ServiceItem, Long> {

    List<ServiceItem> findAllByOrderByServiceIdAsc();

    Optional<ServiceItem> findByServiceName(String serviceName);

    Optional<ServiceItem> findByServiceNameIgnoreCase(String serviceName);

    boolean existsByServiceNameIgnoreCase(String serviceName);
}

