package com.sih.workerreg.config;

import com.sih.workerreg.model.Customer;
import com.sih.workerreg.model.ServiceItem;
import com.sih.workerreg.model.ServiceRequest;
import com.sih.workerreg.model.Worker;
import com.sih.workerreg.repository.CustomerRepository;
import com.sih.workerreg.repository.ServiceRepository;
import com.sih.workerreg.repository.ServiceRequestRepository;
import com.sih.workerreg.repository.WorkerRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class ServiceDataInitializer implements CommandLineRunner {

    private final ServiceRepository serviceRepository;
    private final CustomerRepository customerRepository;
    private final WorkerRepository workerRepository;
    private final ServiceRequestRepository serviceRequestRepository;
    private final PasswordEncoder passwordEncoder;

    public ServiceDataInitializer(ServiceRepository serviceRepository,
                                  CustomerRepository customerRepository,
                                  WorkerRepository workerRepository,
                                  ServiceRequestRepository serviceRequestRepository,
                                  PasswordEncoder passwordEncoder) {
        this.serviceRepository = serviceRepository;
        this.customerRepository = customerRepository;
        this.workerRepository = workerRepository;
        this.serviceRequestRepository = serviceRequestRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {
        String defaultHash = passwordEncoder.encode("Password@123");

        // 1. Seed or Sync Services
        Map<String, ServiceItem> expectedServices = new LinkedHashMap<>();
        expectedServices.put("Plumbing", new ServiceItem("Plumbing", "Pipe repair, leakage fixing, tap and sanitary fittings by certified plumbers.", "🔧", 249.0, 199.0, 150.0, 150.0));
        expectedServices.put("AC Repair & Maintenance", new ServiceItem("AC Repair & Maintenance", "AC servicing, gas leak checks, copper pipe flaring, and PCB diagnostics.", "❄️", 499.0, 299.0, 250.0, 200.0));
        expectedServices.put("Electrical Services", new ServiceItem("Electrical Services", "Complete wiring, circuit breakers, MCB repair, and fixture installations.", "⚡", 199.0, 149.0, 150.0, 150.0));
        expectedServices.put("Cleaning Services", new ServiceItem("Cleaning Services", "Deep home sanitization, kitchen de-greasing, bathroom scrubbing & floor care.", "🧹", 399.0, 299.0, 150.0, 100.0));
        expectedServices.put("Carpenter", new ServiceItem("Carpenter", "Custom woodwork, hinge fixing, lock replacements, and furniture repair.", "🪚", 349.0, 249.0, 180.0, 150.0));
        expectedServices.put("Painting", new ServiceItem("Painting", "Interior room painting, texture finish, primer base, and waterproof putty.", "🎨", 599.0, 399.0, 200.0, 200.0));
        expectedServices.put("Mason / Construction", new ServiceItem("Mason / Construction", "Skilled masonry, plastering, wall restoration, and floor tile fitting.", "🧱", 450.0, 300.0, 200.0, 150.0));
        expectedServices.put("Driver", new ServiceItem("Driver", "Professional verified chauffeurs for local city transit and outstation travel.", "🚗", 350.0, 250.0, 120.0, 100.0));
        expectedServices.put("Cooking Services", new ServiceItem("Cooking Services", "Nutritious homestyle cooking, meal prep, and event catering.", "🍳", 350.0, 250.0, 150.0, 100.0));
        expectedServices.put("Laundry", new ServiceItem("Laundry", "Washing, fabric care, steam pressing, and routine wardrobe assistance.", "🧺", 199.0, 149.0, 100.0, 100.0));

        List<ServiceItem> existingServices = serviceRepository.findAll();
        Map<String, ServiceItem> existingMap = existingServices.stream()
                .collect(Collectors.toMap(ServiceItem::getServiceName, s -> s, (a, b) -> a));

        for (Map.Entry<String, ServiceItem> entry : expectedServices.entrySet()) {
            ServiceItem s = existingMap.get(entry.getKey());
            ServiceItem template = entry.getValue();
            if (s == null) {
                serviceRepository.save(template);
            } else {
                s.setDescription(template.getDescription());
                s.setIcon(template.getIcon());
                s.setBasePrice(template.getBasePrice());
                s.setMinimumCharge(template.getMinimumCharge());
                s.setHourlyRate(template.getHourlyRate());
                s.setEmergencyFee(template.getEmergencyFee());
                s.setActive(true);
                serviceRepository.save(s);
            }
        }
        System.out.println("✅ Synced Services in MySQL.");

        // 2. Seed Default Admin Account if not present
        if (!customerRepository.existsByEmail("admin@sih.gov.in")) {
            Customer adminAccount = new Customer("Federation Administrator", "9876543200", "admin@sih.gov.in", passwordEncoder.encode("Admin@123"), "Lucknow HQ", "Cooperative Federation Secretariat, Lucknow");
            adminAccount.setRole("ADMIN");
            customerRepository.save(adminAccount);
            System.out.println("✅ Seeded Admin Account (admin@sih.gov.in / Admin@123)");
        }

        // 3. Seed Default Customer Account if not present
        Customer defaultCustomer = null;
        if (!customerRepository.existsByEmail("customer@example.com")) {
            Customer customer = new Customer("Aarav Sharma", "9876543212", "customer@example.com", defaultHash, "Gomti Nagar, Lucknow", "House #402, Sector 4, Gomti Nagar, Lucknow");
            customer.setRole("CUSTOMER");
            defaultCustomer = customerRepository.save(customer);
            System.out.println("✅ Seeded Default Customer Account (customer@example.com / Password@123)");
        } else {
            defaultCustomer = customerRepository.findByEmail("customer@example.com").orElse(null);
        }

        // 4. Seed Initial Verified Workers across Lucknow sectors if not present
        if (!workerRepository.existsByEmail("rahul.plumber@example.com")) {
            Worker w1 = new Worker("Rahul Kumar", "9876500001", "rahul.plumber@example.com", "Plumbing", 7, "Gomti Nagar, Lucknow", "Society");
            w1.setPassword(defaultHash);
            w1.setAverageRating(4.8);
            w1.setTotalRatings(34);
            w1.setCompletedJobsCount(48);
            w1.setStatus("VERIFIED");
            w1.setCurrentAvailability("AVAILABLE");
            w1.setLatitude(26.8520);
            w1.setLongitude(80.9980);
            w1.setBio("Certified master plumber with 7+ years of experience in domestic and commercial pipeline installations.");
            workerRepository.save(w1);
        }

        if (!workerRepository.existsByEmail("amit.electric@example.com")) {
            Worker w2 = new Worker("Amit Verma", "9876500002", "amit.electric@example.com", "Electrical Services", 5, "Hazratganj, Lucknow", "Society");
            w2.setPassword(defaultHash);
            w2.setAverageRating(4.6);
            w2.setTotalRatings(28);
            w2.setCompletedJobsCount(39);
            w2.setStatus("VERIFIED");
            w2.setCurrentAvailability("AVAILABLE");
            w2.setLatitude(26.8500);
            w2.setLongitude(80.9450);
            w2.setBio("Licensed electrical wireman trained in high-voltage repairs, home circuit breakers, and lighting.");
            workerRepository.save(w2);
        }

        if (!workerRepository.existsByEmail("sanjay.carpenter@example.com")) {
            Worker w3 = new Worker("Sanjay Yadav", "9876500003", "sanjay.carpenter@example.com", "Carpenter", 10, "Aliganj, Lucknow", "Society");
            w3.setPassword(defaultHash);
            w3.setAverageRating(4.9);
            w3.setTotalRatings(52);
            w3.setCompletedJobsCount(65);
            w3.setStatus("VERIFIED");
            w3.setCurrentAvailability("AVAILABLE");
            w3.setLatitude(26.8920);
            w3.setLongitude(80.9385);
            w3.setBio("Expert carpenter and furniture restoration artisan with over 10 years of trusted cooperative service.");
            workerRepository.save(w3);
        }

        if (!workerRepository.existsByEmail("vijay.plumber@example.com")) {
            Worker w4 = new Worker("Vijay Gupta", "9876500004", "vijay.plumber@example.com", "Plumbing", 6, "Aliganj, Lucknow", "Society");
            w4.setPassword(defaultHash);
            w4.setAverageRating(4.9);
            w4.setTotalRatings(45);
            w4.setCompletedJobsCount(58);
            w4.setStatus("VERIFIED");
            w4.setCurrentAvailability("AVAILABLE");
            w4.setLatitude(26.8910);
            w4.setLongitude(80.9390);
            w4.setBio("Specialist in emergency leakage control, modern bathroom fittings, and sanitary pipelines.");
            workerRepository.save(w4);
        }

        if (!workerRepository.existsByEmail("deepak.ac@example.com")) {
            Worker w5 = new Worker("Deepak Soni", "9876500005", "deepak.ac@example.com", "AC Repair & Maintenance", 8, "Indira Nagar, Lucknow", "Society");
            w5.setPassword(defaultHash);
            w5.setAverageRating(4.7);
            w5.setTotalRatings(38);
            w5.setCompletedJobsCount(44);
            w5.setStatus("VERIFIED");
            w5.setCurrentAvailability("AVAILABLE");
            w5.setLatitude(26.8830);
            w5.setLongitude(80.9850);
            w5.setBio("HVAC certified technician specializing in split & inverter AC servicing and compressor overhauls.");
            workerRepository.save(w5);
        }

        if (!workerRepository.existsByEmail("priya.cleaner@example.com")) {
            Worker w6 = new Worker("Priya Sharma", "9876500006", "priya.cleaner@example.com", "Cleaning Services", 4, "Charbagh, Lucknow", "Society");
            w6.setPassword(defaultHash);
            w6.setAverageRating(4.8);
            w6.setTotalRatings(31);
            w6.setCompletedJobsCount(40);
            w6.setStatus("VERIFIED");
            w6.setCurrentAvailability("AVAILABLE");
            w6.setLatitude(26.8320);
            w6.setLongitude(80.9210);
            w6.setBio("Professional home sanitization specialist trained in eco-friendly steam deep cleaning.");
            workerRepository.save(w6);
        }

        // 5. Ensure existing workers have passwords and required defaults
        List<Worker> allWorkers = workerRepository.findAll();
        for (Worker w : allWorkers) {
            boolean changed = false;
            if (w.getStatus() == null) {
                w.setStatus("VERIFIED");
                changed = true;
            }
            if (w.getCurrentAvailability() == null) {
                w.setCurrentAvailability("AVAILABLE");
                changed = true;
            }
            if (w.getPassword() == null || w.getPassword().trim().isEmpty()) {
                w.setPassword(defaultHash);
                changed = true;
            }
            if (changed) {
                workerRepository.save(w);
            }
        }

        // 6. Seed initial baseline service bookings if none exist
        if (serviceRequestRepository.count() == 0 && defaultCustomer != null && !allWorkers.isEmpty()) {
            Worker wPlumb = allWorkers.stream().filter(w -> "Plumbing".equalsIgnoreCase(w.getSkill())).findFirst().orElse(allWorkers.get(0));
            ServiceItem sPlumb = serviceRepository.findByServiceName("Plumbing").orElse(null);

            if (sPlumb != null) {
                ServiceRequest req1 = new ServiceRequest(defaultCustomer, wPlumb, sPlumb,
                        "Kitchen sink faucet leakage repair and pipe fitting.",
                        "Gomti Nagar, Lucknow", LocalDate.now(), "Evening (4:00 PM - 7:00 PM)");
                req1.setStatus("IN_PROGRESS");
                serviceRequestRepository.save(req1);

                ServiceRequest req2 = new ServiceRequest(defaultCustomer, wPlumb, sPlumb,
                        "Main bathroom pipeline pressure inspection.",
                        "Aliganj, Lucknow", LocalDate.now().minusDays(1), "Morning (9:00 AM - 12:00 PM)");
                req2.setStatus("COMPLETED");
                serviceRequestRepository.save(req2);
                System.out.println("✅ Seeded initial baseline service requests.");

            }
        }
    }
}

