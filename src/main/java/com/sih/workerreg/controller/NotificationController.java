package com.sih.workerreg.controller;

import com.sih.workerreg.model.Notification;
import com.sih.workerreg.service.NotificationService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/notifications")
@CrossOrigin(originPatterns = "*", allowCredentials = "true")
public class NotificationController {

    private final NotificationService notificationService;

    public NotificationController(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    @GetMapping
    public ResponseEntity<List<Notification>> getNotifications(
            @RequestParam(name = "role", defaultValue = "CUSTOMER") String role,
            @RequestParam(name = "id", required = false) Long id) {
        return ResponseEntity.ok(notificationService.getNotificationsForRecipient(role.toUpperCase(), id));
    }

    @GetMapping("/unread-count")
    public ResponseEntity<Map<String, Long>> getUnreadCount(
            @RequestParam(name = "role", defaultValue = "CUSTOMER") String role,
            @RequestParam(name = "id", required = false) Long id) {
        long count = notificationService.getUnreadCount(role.toUpperCase(), id);
        return ResponseEntity.ok(Collections.singletonMap("unreadCount", count));
    }

    @PatchMapping("/{id}/read")
    public ResponseEntity<Map<String, String>> markAsRead(@PathVariable("id") Long id) {
        notificationService.markAsRead(id);
        return ResponseEntity.ok(Collections.singletonMap("message", "Marked as read"));
    }

    @PostMapping("/mark-all-read")
    public ResponseEntity<Map<String, String>> markAllAsRead(
            @RequestParam(name = "role", defaultValue = "CUSTOMER") String role,
            @RequestParam(name = "id", required = false) Long id) {
        notificationService.markAllAsRead(role.toUpperCase(), id);
        return ResponseEntity.ok(Collections.singletonMap("message", "All notifications marked as read"));
    }
}
