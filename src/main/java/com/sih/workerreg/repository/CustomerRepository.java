package com.sih.workerreg.repository;

import com.sih.workerreg.model.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Long> {

    List<Customer> findAllByOrderByCreatedAtDesc();

    boolean existsByEmail(String email);

    boolean existsByPhone(String phone);

    Optional<Customer> findByEmail(String email);
}
