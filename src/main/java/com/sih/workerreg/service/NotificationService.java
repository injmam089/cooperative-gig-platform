package com.sih.workerreg.service;

import com.sih.workerreg.model.Notification;
import com.sih.workerreg.repository.NotificationRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class NotificationService {

    private final NotificationRepository notificationRepository;

    public NotificationService(NotificationRepository notificationRepository) {
        this.notificationRepository = notificationRepository;
    }

    @Transactional
    public Notification createNotification(String recipientType, Long recipientId, String title, String message, String type, Long referenceId) {
        Notification notification = new Notification(recipientType, recipientId, title, message, type, referenceId);
        return notificationRepository.save(notification);
    }

    @Transactional(readOnly = true)
    public List<Notification> getNotificationsForRecipient(String recipientType, Long recipientId) {
        if (recipientId != null) {
            return notificationRepository.findAllByRecipientTypeAndRecipientIdOrderByCreatedAtDesc(recipientType, recipientId);
        } else {
            return notificationRepository.findAllByRecipientTypeOrderByCreatedAtDesc(recipientType);
        }
    }

    @Transactional(readOnly = true)
    public long getUnreadCount(String recipientType, Long recipientId) {
        if (recipientId != null) {
            return notificationRepository.countByRecipientTypeAndRecipientIdAndIsReadFalse(recipientType, recipientId);
        } else {
            return notificationRepository.countByRecipientTypeAndIsReadFalse(recipientType);
        }
    }

    @Transactional
    public void markAsRead(Long notificationId) {
        notificationRepository.findById(notificationId).ifPresent(n -> {
            n.setIsRead(true);
            notificationRepository.save(n);
        });
    }

    @Transactional
    public void markAllAsRead(String recipientType, Long recipientId) {
        List<Notification> notifs = getNotificationsForRecipient(recipientType, recipientId);
        notifs.forEach(n -> n.setIsRead(true));
        notificationRepository.saveAll(notifs);
    }
}
