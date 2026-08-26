package com.sih.workerreg.repository;

import com.sih.workerreg.model.Worker;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WorkerRepository extends JpaRepository<Worker, Long> {
    
    List<Worker> findAllByOrderByCreatedAtDesc();
    
    boolean existsByEmail(String email);
    
    boolean existsByPhone(String phone);

    /**
     * Finds workers whose skill contains the given keyword (case-insensitive).
     */
    List<Worker> findBySkillContainingIgnoreCaseOrderByCreatedAtDesc(String skill);

    /**
     * Flexible multi-term skill search query.
     */
    @Query("SELECT w FROM Worker w WHERE " +
           "LOWER(w.skill) LIKE LOWER(CONCAT('%', :term1, '%')) OR " +
           "LOWER(w.skill) LIKE LOWER(CONCAT('%', :term2, '%')) " +
           "ORDER BY w.createdAt DESC")
    List<Worker> findBySkillFuzzy(@Param("term1") String term1, @Param("term2") String term2);
}
