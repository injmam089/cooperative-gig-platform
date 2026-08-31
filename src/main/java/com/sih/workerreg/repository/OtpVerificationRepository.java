package com.sih.workerreg.repository;

import com.sih.workerreg.model.OtpVerification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface OtpVerificationRepository extends JpaRepository<OtpVerification, Long> {

    /**
     * Finds the most recent unverified OTP record for a given email address.
     */
    Optional<OtpVerification> findTopByEmailAndVerifiedFalseOrderByCreatedAtDesc(String email);

    /**
     * Counts how many OTP requests were created for an email within a given time window (for anti-spam rate limiting).
     */
    long countByEmailAndCreatedAtAfter(String email, LocalDateTime since);

    /**
     * Retrieves all unverified records for an email to allow invalidating them upon new requests.
     */
    List<OtpVerification> findByEmailAndVerifiedFalse(String email);

    /**
     * Invalidates all existing active OTP records for an email.
     */
    @Modifying
    @Transactional
    @Query("UPDATE OtpVerification o SET o.verified = true WHERE o.email = :email AND o.verified = false")
    void invalidatePreviousOtps(@Param("email") String email);

    /**
     * Cleans up expired OTP records older than the specified threshold.
     */
    @Modifying
    @Transactional
    @Query("DELETE FROM OtpVerification o WHERE o.expiresAt < :cutoff")
    void deleteExpiredOtps(@Param("cutoff") LocalDateTime cutoff);
}
