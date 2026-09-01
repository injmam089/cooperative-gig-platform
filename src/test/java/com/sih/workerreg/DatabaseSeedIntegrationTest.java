package com.sih.workerreg;

import com.sih.workerreg.model.*;
import com.sih.workerreg.repository.*;
import com.sih.workerreg.service.AdminAnalyticsService;
import com.sih.workerreg.service.AiWorkforceIntelligenceService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
public class DatabaseSeedIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private WorkerRepository workerRepository;

    @Autowired
    private ServiceRepository serviceRepository;

    @Autowired
    private ServiceRequestRepository serviceRequestRepository;

    @Autowired
    private NotificationRepository notificationRepository;

    @Autowired
    private AdminAnalyticsService adminAnalyticsService;

    @Autowired
    private AiWorkforceIntelligenceService aiService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Test
    public void testDatabaseSeedingCompletenessAndIntegrity() {
        // 1. Verify Services
        List<ServiceItem> services = serviceRepository.findAll();
        assertTrue(services.size() >= 10, "Should have at least 10 services seeded");
        for (ServiceItem s : services) {
            assertNotNull(s.getServiceName(), "Service name must not be null");
            assertNotNull(s.getBasePrice(), "Base price must not be null");
            assertTrue(s.getActive(), "Service should be active");
        }

        // 2. Verify Customers
        List<Customer> customers = customerRepository.findAll();
        assertTrue(customers.size() >= 16, "Should have at least 16 customers seeded");
        Customer admin = customerRepository.findByEmail("admin@sih.gov.in").orElse(null);
        assertNotNull(admin, "Admin account must be present");
        assertEquals("ADMIN", admin.getRole());
        assertTrue(passwordEncoder.matches("Admin@123", admin.getPassword()), "Admin password must match BCrypt hash");

        Customer defaultCustomer = customerRepository.findByEmail("customer@example.com").orElse(null);
        assertNotNull(defaultCustomer, "Default customer account must be present");
        assertTrue(passwordEncoder.matches("Password@123", defaultCustomer.getPassword()), "Customer password must match BCrypt hash");

        // 3. Verify Workers
        List<Worker> workers = workerRepository.findAll();
        assertTrue(workers.size() >= 20, "Should have at least 20 workers seeded");
        long verifiedCount = workers.stream().filter(w -> "VERIFIED".equalsIgnoreCase(w.getStatus())).count();
        long pendingCount = workers.stream().filter(w -> "PENDING_VERIFICATION".equalsIgnoreCase(w.getStatus())).count();
        assertTrue(verifiedCount >= 18, "Should have at least 18 verified workers");
        assertTrue(pendingCount >= 2, "Should have at least 2 pending verification workers");

        for (Worker w : workers) {
            assertNotNull(w.getFullName(), "Worker name must not be null");
            assertNotNull(w.getEmail(), "Worker email must not be null");
            assertNotNull(w.getPhone(), "Worker phone must not be null");
            assertNotNull(w.getSkill(), "Worker skill must not be null");
            assertTrue(passwordEncoder.matches("Password@123", w.getPassword()), "Worker password must match BCrypt hash");
        }

        // 4. Verify Service Requests / Bookings
        List<ServiceRequest> requests = serviceRequestRepository.findAll();
        assertTrue(requests.size() >= 25, "Should have at least 25 service requests seeded");

        long pendingReqs = requests.stream().filter(r -> "PENDING".equalsIgnoreCase(r.getStatus())).count();
        long acceptedReqs = requests.stream().filter(r -> "ACCEPTED".equalsIgnoreCase(r.getStatus())).count();
        long inProgressReqs = requests.stream().filter(r -> "IN_PROGRESS".equalsIgnoreCase(r.getStatus())).count();
        long completedReqs = requests.stream().filter(r -> "COMPLETED".equalsIgnoreCase(r.getStatus())).count();
        long cancelledReqs = requests.stream().filter(r -> "CANCELLED".equalsIgnoreCase(r.getStatus())).count();

        assertTrue(pendingReqs >= 4, "Should have at least 4 PENDING requests");
        assertTrue(acceptedReqs >= 4, "Should have at least 4 ACCEPTED requests");
        assertTrue(inProgressReqs >= 3, "Should have at least 3 IN_PROGRESS requests");
        assertTrue(completedReqs >= 12, "Should have at least 12 COMPLETED requests");
        assertTrue(cancelledReqs >= 2, "Should have at least 2 CANCELLED requests");

        // Verify Foreign Keys on all requests
        for (ServiceRequest r : requests) {
            assertNotNull(r.getCustomer(), "Request must have a valid Customer");
            assertNotNull(r.getWorker(), "Request must have a valid Worker");
            assertNotNull(r.getService(), "Request must have a valid Service");
            assertNotNull(r.getLocation(), "Request must have location");
            assertNotNull(r.getPreferredDate(), "Request must have preferredDate");
            assertNotNull(r.getPreferredTime(), "Request must have preferredTime");
        }

        // Verify completed requests have ratings, review notes, and amountPaid
        List<ServiceRequest> completedList = requests.stream().filter(r -> "COMPLETED".equalsIgnoreCase(r.getStatus())).toList();
        for (ServiceRequest cr : completedList) {
            assertNotNull(cr.getRating(), "Completed request must have a rating");
            assertTrue(cr.getRating() >= 4.0 && cr.getRating() <= 5.0, "Rating should be between 4.0 and 5.0");
            assertNotNull(cr.getReviewNotes(), "Completed request must have review notes");
            assertNotNull(cr.getAmountPaid(), "Completed request must have amount paid");
        }

        // Verify Disputes
        List<ServiceRequest> disputeList = serviceRequestRepository.findByDisputeStatusNot("NONE");
        assertTrue(disputeList.size() >= 3, "Should have at least 3 dispute records");
        long openDisputes = disputeList.stream().filter(d -> "OPEN".equalsIgnoreCase(d.getDisputeStatus())).count();
        long resolvedDisputes = disputeList.stream().filter(d -> "RESOLVED".equalsIgnoreCase(d.getDisputeStatus())).count();
        assertTrue(openDisputes >= 1, "Should have at least 1 open dispute");
        assertTrue(resolvedDisputes >= 2, "Should have at least 2 resolved disputes");

        // 5. Verify Notifications
        List<Notification> notifs = notificationRepository.findAll();
        assertTrue(notifs.size() >= 8, "Should have at least 8 notifications");

        // 6. Verify Admin Analytics Dashboard Metrics
        Map<String, Object> metrics = adminAnalyticsService.getDashboardMetrics();
        assertNotNull(metrics);
        assertTrue(((Number) metrics.get("totalWorkers")).longValue() >= 20);
        assertTrue(((Number) metrics.get("totalCustomers")).longValue() >= 16);
        assertTrue(((Number) metrics.get("totalServices")).longValue() >= 10);
        assertTrue(((Number) metrics.get("totalBookings")).longValue() >= 25);
        assertTrue(((Number) metrics.get("completedJobs")).longValue() >= 12);
        assertTrue(((Number) metrics.get("openDisputes")).longValue() >= 1);

        // 7. Verify AI Workforce Intelligence Predictions using Populated Database
        Map<String, Object> aiPred = aiService.getWorkforcePredictions("Aliganj", "5:00 PM", "LIVE_TELEMETRY");
        assertNotNull(aiPred);
        assertEquals(true, aiPred.get("success"));
        assertEquals(false, aiPred.get("emptyData"));
        assertNotNull(aiPred.get("demandCategories"));
        assertNotNull(aiPred.get("recommendedWorkers"));
        assertNotNull(aiPred.get("executiveSummary"));
    }

    @Autowired
    private javax.sql.DataSource dataSource;

    @Test
    public void testLargeDemoSqlSeedExecutionAndTargetCounts() throws Exception {
        try (java.sql.Connection conn = dataSource.getConnection()) {
            org.springframework.core.io.FileSystemResource resource = new org.springframework.core.io.FileSystemResource("database/demo_seed_large.sql");
            org.springframework.jdbc.datasource.init.ScriptUtils.executeSqlScript(conn, resource);
        }

        // 1. Verify 10 Services
        assertEquals(10, serviceRepository.count(), "Must have exactly 10 distinct service categories");

        // 2. Verify ~30 Customers
        assertTrue(customerRepository.count() >= 30, "Must have at least 30 customers");

        // 3. Verify ~280 Workers
        long totalWorkers = workerRepository.count();
        assertTrue(totalWorkers >= 280, "Must have at least 280 workers, found: " + totalWorkers);

        // Verify ~25-30 workers per service
        for (ServiceItem s : serviceRepository.findAll()) {
            long workersInTrade = workerRepository.findAll().stream().filter(w -> s.getServiceName().equalsIgnoreCase(w.getSkill())).count();
            assertTrue(workersInTrade >= 25, "Service " + s.getServiceName() + " must have >= 25 workers, found: " + workersInTrade);
        }

        // 4. Verify ~120 Bookings
        long totalBookings = serviceRequestRepository.count();
        assertTrue(totalBookings >= 120, "Must have at least 120 bookings, found: " + totalBookings);

        long pendingBookings = serviceRequestRepository.countByStatus("PENDING");
        long acceptedBookings = serviceRequestRepository.countByStatus("ACCEPTED");
        long inProgressBookings = serviceRequestRepository.countByStatus("IN_PROGRESS");
        long completedBookings = serviceRequestRepository.countByStatus("COMPLETED");
        long cancelledBookings = serviceRequestRepository.countByStatus("CANCELLED");

        assertTrue(pendingBookings >= 10, "PENDING bookings >= 10, found: " + pendingBookings);
        assertTrue(acceptedBookings >= 15, "ACCEPTED bookings >= 15, found: " + acceptedBookings);
        assertTrue(inProgressBookings >= 5, "IN_PROGRESS bookings >= 5, found: " + inProgressBookings);
        assertTrue(completedBookings >= 65, "COMPLETED bookings >= 65, found: " + completedBookings);
        assertTrue(cancelledBookings >= 5, "CANCELLED bookings >= 5, found: " + cancelledBookings);

        // 5. Verify Disputes (3-5 total, mostly RESOLVED, 1 OPEN)
        List<ServiceRequest> disputes = serviceRequestRepository.findByDisputeStatusNot("NONE");
        assertTrue(disputes.size() >= 4, "Must have at least 4 disputes, found: " + disputes.size());
        long openCount = disputes.stream().filter(d -> "OPEN".equalsIgnoreCase(d.getDisputeStatus())).count();
        long resolvedCount = disputes.stream().filter(d -> "RESOLVED".equalsIgnoreCase(d.getDisputeStatus())).count();
        assertTrue(openCount >= 1, "Must have at least 1 open dispute");
        assertTrue(resolvedCount >= 3, "Must have at least 3 resolved disputes");

        // 6. Verify Notifications
        assertTrue(notificationRepository.count() >= 20, "Must have at least 20 notifications");

        // 7. Verify Admin Analytics with Large Dataset
        Map<String, Object> metrics = adminAnalyticsService.getDashboardMetrics();
        assertNotNull(metrics);
        assertTrue(((Number) metrics.get("totalWorkers")).longValue() >= 280);
        assertTrue(((Number) metrics.get("totalCustomers")).longValue() >= 30);
        assertTrue(((Number) metrics.get("totalServices")).longValue() == 10);
        assertTrue(((Number) metrics.get("totalBookings")).longValue() >= 120);
        assertTrue(((Number) metrics.get("completedJobs")).longValue() >= 65);
    }

    @Test
    public void testBookingAndAdminEndpointsHttpResponseAndStructure() throws Exception {
        // 1. Verify GET /api/service-requests returns HTTP 200 and JSON array
        mockMvc.perform(get("/api/service-requests")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());

        // 2. Verify GET /api/bookings returns HTTP 200 and JSON array
        mockMvc.perform(get("/api/bookings")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());

        // 3. Verify GET /api/admin/bookings returns HTTP 200 and JSON array
        mockMvc.perform(get("/api/admin/bookings")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());

        // 4. Verify GET /api/admin/dashboard returns aggregated metrics
        mockMvc.perform(get("/api/admin/dashboard")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.totalWorkers").exists())
                .andExpect(jsonPath("$.totalCustomers").exists())
                .andExpect(jsonPath("$.totalBookings").exists())
                .andExpect(jsonPath("$.totalServices").value(10));

        // 5. Verify GET /api/admin/complaints returns HTTP 200
        mockMvc.perform(get("/api/admin/complaints")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());
    }
}