package com.sih.workerreg.repository;

import com.sih.workerreg.model.Worker;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface WorkerRepository extends JpaRepository<Worker, Long> {
    
    List<Worker> findAllByOrderByCreatedAtDesc();
    
    boolean existsByEmail(String email);
    
    boolean existsByPhone(String phone);

    Optional<Worker> findByEmail(String email);

    List<Worker> findByStatusOrderByCreatedAtDesc(String status);

    long countByStatus(String status);

    List<Worker> findByStatusAndCurrentAvailability(String status, String currentAvailability);

    List<Worker> findBySkillContainingIgnoreCaseAndStatusAndCurrentAvailability(String skill, String status, String currentAvailability);

    List<Worker> findByLocationContainingIgnoreCase(String location);

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

    /**
     * Finds workers matching the specified city with optional skill and status filters.
     * Supports locality matching (e.g. 'Aliganj, Lucknow' matches 'Lucknow').
     * Ranked by averageRating DESC, experienceYears DESC, createdAt DESC.
     */
    @Query("SELECT w FROM Worker w WHERE " +
           "(:city IS NOT NULL AND (LOWER(TRIM(w.location)) = LOWER(TRIM(:city)) OR LOWER(w.location) LIKE LOWER(CONCAT('%', TRIM(:city), '%')))) " +
           "AND (:skill IS NULL OR :skill = '' OR LOWER(w.skill) LIKE LOWER(CONCAT('%', TRIM(:skill), '%'))) " +
           "AND (:status IS NULL OR :status = '' OR UPPER(w.status) = UPPER(TRIM(:status))) " +
           "ORDER BY w.averageRating DESC, w.experienceYears DESC, w.createdAt DESC")
    List<Worker> findNearbyWorkersByCity(
            @Param("city") String city,
            @Param("skill") String skill,
            @Param("status") String status);

    /**
     * Finds workers by city with ranking by average rating and experience.
     */
    @Query("SELECT w FROM Worker w WHERE " +
           "LOWER(TRIM(w.location)) = LOWER(TRIM(:city)) OR LOWER(w.location) LIKE LOWER(CONCAT('%', TRIM(:city), '%')) " +
           "ORDER BY w.averageRating DESC, w.experienceYears DESC, w.createdAt DESC")
    List<Worker> findByCityIgnoreCase(@Param("city") String city);
}


