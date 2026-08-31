package com.sih.workerreg.repository;

import com.sih.workerreg.model.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Long> {

    List<Notification> findAllByRecipientTypeAndRecipientIdOrderByCreatedAtDesc(String recipientType, Long recipientId);

    List<Notification> findAllByRecipientTypeOrderByCreatedAtDesc(String recipientType);

    long countByRecipientTypeAndRecipientIdAndIsReadFalse(String recipientType, Long recipientId);

    long countByRecipientTypeAndIsReadFalse(String recipientType);
}
