package com.sih.workerreg.config;

import com.sih.workerreg.model.*;
import com.sih.workerreg.repository.*;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Component
public class ServiceDataInitializer implements CommandLineRunner {

    private final ServiceRepository serviceRepository;
    private final CustomerRepository customerRepository;
    private final WorkerRepository workerRepository;
    private final ServiceRequestRepository serviceRequestRepository;
    private final NotificationRepository notificationRepository;
    private final PasswordEncoder passwordEncoder;

    public ServiceDataInitializer(ServiceRepository serviceRepository,
                                  CustomerRepository customerRepository,
                                  WorkerRepository workerRepository,
                                  ServiceRequestRepository serviceRequestRepository,
                                  NotificationRepository notificationRepository,
                                  PasswordEncoder passwordEncoder) {
        this.serviceRepository = serviceRepository;
        this.customerRepository = customerRepository;
        this.workerRepository = workerRepository;
        this.serviceRequestRepository = serviceRequestRepository;
        this.notificationRepository = notificationRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {
        String defaultHash = passwordEncoder.encode("Password@123");
        String adminHash = passwordEncoder.encode("Admin@123");

        // 1. Seed or Synchronize Service Catalog
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
        System.out.println("✅ Synced 10 Service Categories in Database.");

        // 2. Seed Realistic Customers (16 accounts: 1 Admin + 15 Residents)
        List<CustomerData> customerDefs = Arrays.asList(
                new CustomerData("Federation Administrator", "9876543200", "admin@sih.gov.in", adminHash, "ADMIN", "Lucknow HQ", "Cooperative Federation Secretariat, Lucknow"),
                new CustomerData("Aarav Sharma", "9876543212", "customer@example.com", defaultHash, "CUSTOMER", "Gomti Nagar, Lucknow", "House #402, Sector 4, Gomti Nagar, Lucknow"),
                new CustomerData("Rohit Mehta", "9876510001", "rohit.mehta@example.com", defaultHash, "CUSTOMER", "Aliganj, Lucknow", "Flat 204, Royal Palms, Aliganj, Lucknow"),
                new CustomerData("Sneha Patel", "9876510002", "sneha.patel@example.com", defaultHash, "CUSTOMER", "Hazratganj, Lucknow", "12/A Park Road, Hazratganj, Lucknow"),
                new CustomerData("Vikram Singh", "9876510003", "vikram.singh@example.com", defaultHash, "CUSTOMER", "Indira Nagar, Lucknow", "B-88 Sector 14, Indira Nagar, Lucknow"),
                new CustomerData("Ananya Gupta", "9876510004", "ananya.gupta@example.com", defaultHash, "CUSTOMER", "Mahanagar, Lucknow", "Plot 45, Gole Market, Mahanagar, Lucknow"),
                new CustomerData("Manish Tiwari", "9876510005", "manish.tiwari@example.com", defaultHash, "CUSTOMER", "Gomti Nagar, Lucknow", "3/110 Vibhuti Khand, Gomti Nagar, Lucknow"),
                new CustomerData("Pooja Shukla", "9876510006", "pooja.shukla@example.com", defaultHash, "CUSTOMER", "Vikas Nagar, Lucknow", "Sector 8, Vikas Nagar, Lucknow"),
                new CustomerData("Rajat Mishra", "9876510007", "rajat.mishra@example.com", defaultHash, "CUSTOMER", "Jankipuram, Lucknow", "Sector F, Jankipuram Extension, Lucknow"),
                new CustomerData("Deepika Saxena", "9876510008", "deepika.saxena@example.com", defaultHash, "CUSTOMER", "Ashiyana, Lucknow", "Sector L, LDA Colony, Ashiyana, Lucknow"),
                new CustomerData("Siddharth Verma", "9876510009", "siddharth.verma@example.com", defaultHash, "CUSTOMER", "Rajajipuram, Lucknow", "Block E, Rajajipuram, Lucknow"),
                new CustomerData("Neha Dwivedi", "9876510010", "neha.dwivedi@example.com", defaultHash, "CUSTOMER", "Aliganj, Lucknow", "Sector B, Aliganj, Lucknow"),
                new CustomerData("Karan Malhotra", "9876510011", "karan.malhotra@example.com", defaultHash, "CUSTOMER", "Hazratganj, Lucknow", "Civil Lines, Hazratganj, Lucknow"),
                new CustomerData("Shreya Pandey", "9876510012", "shreya.pandey@example.com", defaultHash, "CUSTOMER", "Indira Nagar, Lucknow", "Sector 19, Indira Nagar, Lucknow"),
                new CustomerData("Alok Tripathi", "9876510013", "alok.tripathi@example.com", defaultHash, "CUSTOMER", "Gomti Nagar, Lucknow", "Vipul Khand 2, Gomti Nagar, Lucknow"),
                new CustomerData("Ritu Agarwal", "9876510014", "ritu.agarwal@example.com", defaultHash, "CUSTOMER", "Mahanagar, Lucknow", "Sector C, Mahanagar, Lucknow")
        );

        for (CustomerData cd : customerDefs) {
            if (!customerRepository.existsByEmail(cd.email)) {
                Customer c = new Customer(cd.name, cd.phone, cd.email, cd.password, cd.location, cd.address);
                c.setRole(cd.role);
                customerRepository.save(c);
            }
        }
        System.out.println("✅ Seeded 16 Customer Profiles in Database.");

        // 3. Seed Realistic Workers (20 skilled artisans across all trade categories)
        List<WorkerData> workerDefs = Arrays.asList(
                new WorkerData("Rahul Kumar", "9876500001", "rahul.plumber@example.com", "Plumbing", 7, "Gomti Nagar, Lucknow", 26.8520, 80.9980, 4.8, 34, 48, "VERIFIED", "AVAILABLE", "Certified master plumber with 7+ years of experience in domestic and commercial pipeline installations.", "Society"),
                new WorkerData("Amit Verma", "9876500002", "amit.electric@example.com", "Electrical Services", 5, "Hazratganj, Lucknow", 26.8500, 80.9450, 4.6, 28, 39, "VERIFIED", "AVAILABLE", "Licensed electrical wireman trained in high-voltage repairs, home circuit breakers, and lighting.", "Society"),
                new WorkerData("Sanjay Yadav", "9876500003", "sanjay.carpenter@example.com", "Carpenter", 10, "Aliganj, Lucknow", 26.8920, 80.9385, 4.9, 52, 65, "VERIFIED", "AVAILABLE", "Expert carpenter and furniture restoration artisan with over 10 years of trusted cooperative service.", "Society"),
                new WorkerData("Vijay Gupta", "9876500004", "vijay.plumber@example.com", "Plumbing", 6, "Aliganj, Lucknow", 26.8910, 80.9390, 4.9, 45, 58, "VERIFIED", "AVAILABLE", "Specialist in emergency leakage control, modern bathroom fittings, and sanitary pipelines.", "Society"),
                new WorkerData("Deepak Soni", "9876500005", "deepak.ac@example.com", "AC Repair & Maintenance", 8, "Indira Nagar, Lucknow", 26.8830, 80.9850, 4.7, 38, 44, "VERIFIED", "AVAILABLE", "HVAC certified technician specializing in split & inverter AC servicing and compressor overhauls.", "Society"),
                new WorkerData("Priya Sharma", "9876500006", "priya.cleaner@example.com", "Cleaning Services", 4, "Charbagh, Lucknow", 26.8320, 80.9210, 4.8, 31, 40, "VERIFIED", "AVAILABLE", "Professional home sanitization specialist trained in eco-friendly steam deep cleaning.", "Society"),
                new WorkerData("Dinesh Maurya", "9876500007", "dinesh.painter@example.com", "Painting", 8, "Hazratganj, Lucknow", 26.8490, 80.9470, 4.7, 33, 42, "VERIFIED", "AVAILABLE", "Master painter specializing in premium interior textures, damp-proof priming, and emulsion finishing.", "Society"),
                new WorkerData("Ramakant Bind", "9876500008", "ramakant.mason@example.com", "Mason / Construction", 12, "Ashiyana, Lucknow", 26.7910, 80.9020, 4.8, 47, 60, "VERIFIED", "AVAILABLE", "Veteran structural mason skilled in brickwork, plastering, flooring tile alignment, and renovation.", "Cooperative"),
                new WorkerData("Mohammad Aslam", "9876500009", "mohd.driver@example.com", "Driver", 11, "Hazratganj, Lucknow", 26.8480, 80.9440, 4.9, 63, 82, "VERIFIED", "AVAILABLE", "Commercial licensed professional chauffeur with 10+ years accident-free city and highway transit.", "Cooperative"),
                new WorkerData("Geeta Mishra", "9876500010", "geeta.cook@example.com", "Cooking Services", 8, "Mahanagar, Lucknow", 26.8710, 80.9520, 4.9, 41, 53, "VERIFIED", "AVAILABLE", "Expert home chef trained in balanced nutritious meal preparation, North Indian delicacies, and catering.", "Self"),
                new WorkerData("Ramesh Yadav", "9876500011", "ramesh.plumber@example.com", "Plumbing", 4, "Indira Nagar, Lucknow", 26.8830, 80.9850, 4.6, 19, 27, "VERIFIED", "AVAILABLE", "Punctual plumbing technician experienced in drainage unclogging, water motors, and geyser installations.", "Self"),
                new WorkerData("Arun Kushwaha", "9876500012", "arun.ac@example.com", "AC Repair & Maintenance", 5, "Gomti Nagar, Lucknow", 26.8520, 80.9980, 4.8, 26, 35, "VERIFIED", "AVAILABLE", "Qualified cooling technician specialized in PCB repair, capacitor replacement, and duct cleaning.", "Society"),
                new WorkerData("Suresh Chaurasia", "9876500013", "suresh.electric@example.com", "Electrical Services", 9, "Aliganj, Lucknow", 26.8915, 80.9410, 4.9, 51, 68, "VERIFIED", "AVAILABLE", "Senior certified electrician skilled in main distribution panels, surge protection, and invertor setups.", "Cooperative"),
                new WorkerData("Kamal Nayan", "9876500014", "kamal.electric@example.com", "Electrical Services", 3, "Vikas Nagar, Lucknow", 26.8980, 80.9520, 4.5, 14, 20, "PENDING_VERIFICATION", "AVAILABLE", "ITI certified apprentice electrician seeking cooperative onboarding for residential switchboard wiring.", "Self"),
                new WorkerData("Sunita Devi", "9876500015", "sunita.cleaner@example.com", "Cleaning Services", 6, "Mahanagar, Lucknow", 26.8720, 80.9530, 4.9, 42, 55, "VERIFIED", "AVAILABLE", "Specialist in kitchen degreasing, bathroom scrubbing, and post-construction thorough cleanups.", "Society"),
                new WorkerData("Harish Vishwakarma", "9876500016", "harish.carpenter@example.com", "Carpenter", 7, "Gomti Nagar, Lucknow", 26.8540, 80.9990, 4.7, 29, 38, "VERIFIED", "AVAILABLE", "Artisan carpenter expert in modular kitchen cabinets, wardrobe sliding channels, and antique repairs.", "Cooperative"),
                new WorkerData("Mukesh Rawat", "9876500017", "mukesh.painter@example.com", "Painting", 4, "Jankipuram, Lucknow", 26.9120, 80.9450, 4.4, 16, 22, "PENDING_VERIFICATION", "AVAILABLE", "Skilled wall decorator trained in stencil work, waterproofing coatings, and exterior painting.", "Self"),
                new WorkerData("Santosh Paswan", "9876500018", "santosh.mason@example.com", "Mason / Construction", 9, "Rajajipuram, Lucknow", 26.8510, 80.8920, 4.6, 23, 31, "VERIFIED", "AVAILABLE", "Experienced mason specializing in wall crack repair, terrace waterproofing, and tiling.", "Cooperative"),
                new WorkerData("Pradeep Srivastava", "9876500019", "pradeep.driver@example.com", "Driver", 6, "Gomti Nagar, Lucknow", 26.8530, 80.9970, 4.7, 35, 49, "VERIFIED", "AVAILABLE", "Reliable family chauffeur with extensive knowledge of Lucknow-NCR routes and airport transfers.", "Self"),
                new WorkerData("Radheshyam Kanojia", "9876500020", "radhey.laundry@example.com", "Laundry", 10, "Aliganj, Lucknow", 26.8900, 80.9380, 4.8, 37, 46, "VERIFIED", "AVAILABLE", "Doorstep laundry specialist providing steam pressing, fabric conditioning, and delicate garment care.", "Society")
        );

        for (WorkerData wd : workerDefs) {
            Worker w = workerRepository.findByEmail(wd.email).orElse(null);
            if (w == null) {
                w = new Worker(wd.name, wd.phone, wd.email, wd.skill, wd.experienceYears, wd.location, wd.invitedBy);
                w.setPassword(defaultHash);
                w.setLatitude(wd.latitude);
                w.setLongitude(wd.longitude);
                w.setAverageRating(wd.rating);
                w.setTotalRatings(wd.ratingsCount);
                w.setCompletedJobsCount(wd.completedJobs);
                w.setStatus(wd.status);
                w.setCurrentAvailability(wd.availability);
                w.setBio(wd.bio);
                workerRepository.save(w);
            } else {
                if (w.getPassword() == null || w.getPassword().trim().isEmpty()) {
                    w.setPassword(defaultHash);
                }
                if (w.getStatus() == null) {
                    w.setStatus(wd.status);
                }
                if (w.getCurrentAvailability() == null) {
                    w.setCurrentAvailability(wd.availability);
                }
                workerRepository.save(w);
            }
        }
        System.out.println("✅ Seeded 20 Verified & Qualified Worker Profiles in Database.");

        // 4. Seed Service Requests / Bookings (25 realistic requests covering varied statuses & dates)
        if (serviceRequestRepository.count() < 20) {
            Map<String, Customer> custMap = customerRepository.findAll().stream()
                    .collect(Collectors.toMap(Customer::getEmail, c -> c, (a, b) -> a));
            Map<String, Worker> workMap = workerRepository.findAll().stream()
                    .collect(Collectors.toMap(Worker::getEmail, w -> w, (a, b) -> a));
            Map<String, ServiceItem> servMap = serviceRepository.findAll().stream()
                    .collect(Collectors.toMap(ServiceItem::getServiceName, s -> s, (a, b) -> a));

            Customer cAarav = custMap.getOrDefault("customer@example.com", custMap.values().stream().findFirst().orElse(null));
            Customer cRohit = custMap.getOrDefault("rohit.mehta@example.com", cAarav);
            Customer cSneha = custMap.getOrDefault("sneha.patel@example.com", cAarav);
            Customer cVikram = custMap.getOrDefault("vikram.singh@example.com", cAarav);
            Customer cAnanya = custMap.getOrDefault("ananya.gupta@example.com", cAarav);
            Customer cManish = custMap.getOrDefault("manish.tiwari@example.com", cAarav);
            Customer cPooja = custMap.getOrDefault("pooja.shukla@example.com", cAarav);
            Customer cRajat = custMap.getOrDefault("rajat.mishra@example.com", cAarav);
            Customer cDeepika = custMap.getOrDefault("deepika.saxena@example.com", cAarav);
            Customer cSiddharth = custMap.getOrDefault("siddharth.verma@example.com", cAarav);
            Customer cNeha = custMap.getOrDefault("neha.dwivedi@example.com", cAarav);
            Customer cKaran = custMap.getOrDefault("karan.malhotra@example.com", cAarav);
            Customer cShreya = custMap.getOrDefault("shreya.pandey@example.com", cAarav);
            Customer cAlok = custMap.getOrDefault("alok.tripathi@example.com", cAarav);
            Customer cRitu = custMap.getOrDefault("ritu.agarwal@example.com", cAarav);

            Worker wRahulPlumb = workMap.get("rahul.plumber@example.com");
            Worker wVijayPlumb = workMap.get("vijay.plumber@example.com");
            Worker wAmitElec = workMap.get("amit.electric@example.com");
            Worker wSureshElec = workMap.get("suresh.electric@example.com");
            Worker wDeepakAc = workMap.get("deepak.ac@example.com");
            Worker wArunAc = workMap.get("arun.ac@example.com");
            Worker wPriyaClean = workMap.get("priya.cleaner@example.com");
            Worker wSunitaClean = workMap.get("sunita.cleaner@example.com");
            Worker wSanjayCarp = workMap.get("sanjay.carpenter@example.com");
            Worker wHarishCarp = workMap.get("harish.carpenter@example.com");
            Worker wDineshPaint = workMap.get("dinesh.painter@example.com");
            Worker wRamakantMason = workMap.get("ramakant.mason@example.com");
            Worker wSantoshMason = workMap.get("santosh.mason@example.com");
            Worker wAslamDriver = workMap.get("mohd.driver@example.com");
            Worker wGeetaCook = workMap.get("geeta.cook@example.com");
            Worker wRadheyLaundry = workMap.get("radhey.laundry@example.com");

            ServiceItem sPlumb = servMap.get("Plumbing");
            ServiceItem sAc = servMap.get("AC Repair & Maintenance");
            ServiceItem sElec = servMap.get("Electrical Services");
            ServiceItem sClean = servMap.get("Cleaning Services");
            ServiceItem sCarp = servMap.get("Carpenter");
            ServiceItem sPaint = servMap.get("Painting");
            ServiceItem sMason = servMap.get("Mason / Construction");
            ServiceItem sDriver = servMap.get("Driver");
            ServiceItem sCook = servMap.get("Cooking Services");
            ServiceItem sLaundry = servMap.get("Laundry");

            LocalDateTime now = LocalDateTime.now();

            List<ServiceRequest> requestsToSave = new ArrayList<>();

            // 1-4. PENDING (4 Requests)
            ServiceRequest r1 = createRequest(cAarav, wRahulPlumb, sPlumb, "Kitchen sink faucet water pressure issue and replacement pipe fitting.", "Gomti Nagar, Lucknow", LocalDate.now().plusDays(1), "Morning (9:00 AM - 12:00 PM)", "PENDING");
            ServiceRequest r2 = createRequest(cSneha, wAmitElec, sElec, "Switchboard sparking and ceiling fan regulator replacement.", "Hazratganj, Lucknow", LocalDate.now().plusDays(1), "Afternoon (1:00 PM - 4:00 PM)", "PENDING");
            ServiceRequest r3 = createRequest(cRohit, wDeepakAc, sAc, "Split AC cooling efficiency drop before summer surge inspection.", "Aliganj, Lucknow", LocalDate.now().plusDays(1), "Evening (4:00 PM - 7:00 PM)", "PENDING");
            ServiceRequest r4 = createRequest(cAnanya, wSunitaClean, sClean, "Pre-festival full 3BHK deep sanitization and kitchen floor scrubbing.", "Mahanagar, Lucknow", LocalDate.now().plusDays(2), "Morning (9:00 AM - 12:00 PM)", "PENDING");
            requestsToSave.addAll(Arrays.asList(r1, r2, r3, r4));

            // 5-8. ACCEPTED (4 Requests)
            ServiceRequest r5 = createRequest(cVikram, wSanjayCarp, sCarp, "Balcony wooden door alignment and heavy safety latch replacement.", "Indira Nagar, Lucknow", LocalDate.now(), "Morning (9:00 AM - 12:00 PM)", "ACCEPTED");
            r5.setAcceptedAt(now.minusHours(2));
            ServiceRequest r6 = createRequest(cPooja, wDineshPaint, sPaint, "Living room accent wall texture painting and primer coating.", "Vikas Nagar, Lucknow", LocalDate.now(), "Afternoon (1:00 PM - 4:00 PM)", "ACCEPTED");
            r6.setAcceptedAt(now.minusHours(3));
            ServiceRequest r7 = createRequest(cRajat, wAslamDriver, sDriver, "Outstation transit drive from Lucknow to Kanpur round trip.", "Jankipuram, Lucknow", LocalDate.now(), "Evening (4:00 PM - 7:00 PM)", "ACCEPTED");
            r7.setAcceptedAt(now.minusHours(1));
            ServiceRequest r8 = createRequest(cDeepika, wRamakantMason, sMason, "Bathroom floor tile leveling and water slope re-cementing.", "Ashiyana, Lucknow", LocalDate.now(), "Morning (9:00 AM - 12:00 PM)", "ACCEPTED");
            r8.setAcceptedAt(now.minusHours(4));
            requestsToSave.addAll(Arrays.asList(r5, r6, r7, r8));

            // 9-11. IN_PROGRESS (3 Requests)
            ServiceRequest r9 = createRequest(cAarav, wVijayPlumb, sPlumb, "Main bathroom pipeline pressure inspection & leak arrest.", "Aliganj, Lucknow", LocalDate.now(), "Morning (9:00 AM - 12:00 PM)", "IN_PROGRESS");
            r9.setAcceptedAt(now.minusHours(2));
            r9.setStartedAt(now.minusMinutes(45));
            ServiceRequest r10 = createRequest(cSiddharth, wSureshElec, sElec, "Distribution board MCB tripping and fuse replacement.", "Rajajipuram, Lucknow", LocalDate.now(), "Afternoon (1:00 PM - 4:00 PM)", "IN_PROGRESS");
            r10.setAcceptedAt(now.minusHours(3));
            r10.setStartedAt(now.minusHours(1));
            ServiceRequest r11 = createRequest(cNeha, wGeetaCook, sCook, "Family dinner meal preparation and nutrition menu cooking.", "Aliganj, Lucknow", LocalDate.now(), "Evening (4:00 PM - 7:00 PM)", "IN_PROGRESS");
            r11.setAcceptedAt(now.minusHours(2));
            r11.setStartedAt(now.minusMinutes(30));
            requestsToSave.addAll(Arrays.asList(r9, r10, r11));

            // 12-23. COMPLETED (12 Requests with realistic reviews & ratings)
            ServiceRequest r12 = createCompletedRequest(cAarav, wRahulPlumb, sPlumb, "Kitchen sink faucet leakage repair and pipe fitting.", "Gomti Nagar, Lucknow", LocalDate.now().minusDays(1), "Evening (4:00 PM - 7:00 PM)", 249.0, 5.0, "Prompt response! Fixed the sink faucet and pipe fitting within 30 minutes without any mess.", now.minusDays(1));
            ServiceRequest r13 = createCompletedRequest(cRohit, wDeepakAc, sAc, "Inverter AC gas top-up and filter steam cleaning.", "Aliganj, Lucknow", LocalDate.now().minusDays(2), "Morning (9:00 AM - 12:00 PM)", 499.0, 4.8, "Very knowledgeable technician. Checked copper coils and gas pressure thoroughly.", now.minusDays(2));
            ServiceRequest r14 = createCompletedRequest(cSneha, wAmitElec, sElec, "Inverter battery wiring connection and circuit check.", "Hazratganj, Lucknow", LocalDate.now().minusDays(3), "Afternoon (1:00 PM - 4:00 PM)", 199.0, 4.7, "Clean wire organization and verified load capacity. Zero platform markup.", now.minusDays(3));
            ServiceRequest r15 = createCompletedRequest(cVikram, wPriyaClean, sClean, "Kitchen grease removal and chimney steam cleaning.", "Indira Nagar, Lucknow", LocalDate.now().minusDays(4), "Morning (9:00 AM - 12:00 PM)", 399.0, 4.9, "Impressed by the eco-friendly steam clean. Kitchen looks brand new.", now.minusDays(4));
            ServiceRequest r16 = createCompletedRequest(cAnanya, wHarishCarp, sCarp, "Wardrobe slider rail repair and lock replacement.", "Mahanagar, Lucknow", LocalDate.now().minusDays(5), "Evening (4:00 PM - 7:00 PM)", 349.0, 5.0, "Smooth sliding doors restored. Highly skilled cooperative carpenter.", now.minusDays(5));
            ServiceRequest r17 = createCompletedRequest(cManish, wDineshPaint, sPaint, "Bedroom waterproof putty and anti-fungal paint coating.", "Gomti Nagar, Lucknow", LocalDate.now().minusDays(6), "Morning (9:00 AM - 12:00 PM)", 599.0, 4.8, "Careful masking and clean brush strokes. Finished on schedule.", now.minusDays(6));
            ServiceRequest r18 = createCompletedRequest(cPooja, wRadheyLaundry, sLaundry, "Curtains steam pressing and winter woolens care.", "Vikas Nagar, Lucknow", LocalDate.now().minusDays(7), "Afternoon (1:00 PM - 4:00 PM)", 199.0, 4.9, "Punctual doorstep pickup and crisp steam pressing. Very affordable.", now.minusDays(7));
            ServiceRequest r19 = createCompletedRequest(cRajat, wAslamDriver, sDriver, "Full day local city chauffeur duty for family shopping.", "Jankipuram, Lucknow", LocalDate.now().minusDays(8), "Morning (9:00 AM - 12:00 PM)", 350.0, 5.0, "Punctual, polite, and navigated city traffic with extreme caution.", now.minusDays(8));
            ServiceRequest r20 = createCompletedRequest(cDeepika, wGeetaCook, sCook, "Weekend brunch cooking and traditional Awadhi dishes.", "Ashiyana, Lucknow", LocalDate.now().minusDays(9), "Morning (9:00 AM - 12:00 PM)", 350.0, 5.0, "Delicious authentic food, hygienic kitchen practices. Family loved it!", now.minusDays(9));
            ServiceRequest r21 = createCompletedRequest(cSiddharth, wSantoshMason, sMason, "Main gate boundary wall crack sealing and plastering.", "Rajajipuram, Lucknow", LocalDate.now().minusDays(10), "Afternoon (1:00 PM - 4:00 PM)", 450.0, 4.6, "Solid masonry finish and proper curing instructions provided.", now.minusDays(10));

            // Dispute 1 (Resolved)
            ServiceRequest r22 = createCompletedRequest(cKaran, wVijayPlumb, sPlumb, "Overhead tank water float valve replacement.", "Hazratganj, Lucknow", LocalDate.now().minusDays(5), "Morning (9:00 AM - 12:00 PM)", 249.0, 4.4, "Float valve working fine now after cooperative resolution.", now.minusDays(5));
            r22.setDisputeStatus("RESOLVED");
            r22.setDisputeReason("Artisan arrived 40 minutes past scheduled window due to city parade route blockage.");
            r22.setDisputeResolution("Cooperative coordinator verified traffic delay. Artisan waived emergency surcharge and completed service to satisfaction.");

            // Dispute 2 (Resolved)
            ServiceRequest r23 = createCompletedRequest(cShreya, wArunAc, sAc, "Window AC cooling coil chemical cleaning.", "Indira Nagar, Lucknow", LocalDate.now().minusDays(3), "Afternoon (1:00 PM - 4:00 PM)", 499.0, 4.5, "Cooling restored completely after technician revisited.", now.minusDays(3));
            r23.setDisputeStatus("RESOLVED");
            r23.setDisputeReason("Minor water drip from drainage pipe after first cooling cycle.");
            r23.setDisputeResolution("Artisan revisited within 2 hours, re-aligned drainage slope, and confirmed leak-free operation.");

            requestsToSave.addAll(Arrays.asList(r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23));

            // 24-25. CANCELLED (2 Requests, 1 with Open Dispute)
            ServiceRequest r24 = createRequest(cAlok, wSureshElec, sElec, "Balcony decorative light strip installation.", "Gomti Nagar, Lucknow", LocalDate.now().minusDays(2), "Evening (4:00 PM - 7:00 PM)", "CANCELLED");
            ServiceRequest r25 = createRequest(cRitu, wHarishCarp, sCarp, "Study table drawer repair and hinge lubrication.", "Mahanagar, Lucknow", LocalDate.now().minusDays(1), "Morning (9:00 AM - 12:00 PM)", "CANCELLED");
            r25.setDisputeStatus("OPEN");
            r25.setDisputeReason("Customer requested emergency reschedule due to unexpected travel; asked for slot re-booking without cancellation penalty.");
            r25.setDisputeResolution("Under cooperative mediation: re-booking slot requested for upcoming weekend.");

            requestsToSave.addAll(Arrays.asList(r24, r25));

            serviceRequestRepository.saveAll(requestsToSave);
            System.out.println("✅ Seeded 25 Realistic Bookings & Service Requests in Database.");
        }

        // 5. Seed System & Booking Notifications
        if (notificationRepository.count() < 5) {
            List<Notification> notifs = Arrays.asList(
                    new Notification("CUSTOMER", 2L, "Booking Confirmed #1", "Your plumbing request #1 has been confirmed with Rahul Kumar.", "BOOKING", 1L),
                    new Notification("WORKER", 1L, "New Service Assignment #1", "New plumbing service request received from Gomti Nagar, Lucknow.", "BOOKING", 1L),
                    new Notification("CUSTOMER", 3L, "Service Completed #13", "Your AC servicing has been marked completed. Thank you for choosing Cooperative Gig!", "BOOKING", 13L),
                    new Notification("WORKER", 5L, "Direct Payout Credited", "₹499 credited for AC servicing job #13 with 0% platform commission deduction.", "SYSTEM", 13L),
                    new Notification("ADMIN", 1L, "New Worker Verification", "Kamal Nayan (Electrical Services) has submitted documents for verification.", "SYSTEM", 14L),
                    new Notification("ADMIN", 1L, "Dispute Mediation Request", "Dispute raised for Booking #25 (Ritu Agarwal / Harish Vishwakarma).", "DISPUTE", 25L),
                    new Notification("CUSTOMER", 13L, "Dispute Resolved #22", "Dispute for request #22 resolved. Emergency fee adjusted amicably.", "DISPUTE", 22L),
                    new Notification("WORKER", 10L, "Customer Review Received", "5.0-star rating received from Deepika Saxena for weekend brunch cooking.", "BOOKING", 20L)
            );
            notificationRepository.saveAll(notifs);
            System.out.println("✅ Seeded 8 Contextual Notifications in Database.");
        }
    }

    private ServiceRequest createRequest(Customer customer, Worker worker, ServiceItem service, String desc, String loc, LocalDate date, String time, String status) {
        ServiceRequest req = new ServiceRequest(customer, worker, service, desc, loc, date, time);
        req.setStatus(status);
        req.setDisputeStatus("NONE");
        return req;
    }

    private ServiceRequest createCompletedRequest(Customer customer, Worker worker, ServiceItem service, String desc, String loc, LocalDate date, String time, Double amount, Double rating, String review, LocalDateTime completedAt) {
        ServiceRequest req = new ServiceRequest(customer, worker, service, desc, loc, date, time);
        req.setStatus("COMPLETED");
        req.setDisputeStatus("NONE");
        req.setAmountPaid(amount);
        req.setRating(rating);
        req.setReviewNotes(review);
        req.setAcceptedAt(completedAt.minusHours(2));
        req.setStartedAt(completedAt.minusHours(1));
        req.setCompletedAt(completedAt);
        return req;
    }

    // Helper static DTO classes for clean seeding data definitions
    private static class CustomerData {
        String name;
        String phone;
        String email;
        String password;
        String role;
        String location;
        String address;

        CustomerData(String name, String phone, String email, String password, String role, String location, String address) {
            this.name = name;
            this.phone = phone;
            this.email = email;
            this.password = password;
            this.role = role;
            this.location = location;
            this.address = address;
        }
    }

    private static class WorkerData {
        String name;
        String phone;
        String email;
        String skill;
        int experienceYears;
        String location;
        double latitude;
        double longitude;
        double rating;
        int ratingsCount;
        int completedJobs;
        String status;
        String availability;
        String bio;
        String invitedBy;

        WorkerData(String name, String phone, String email, String skill, int experienceYears, String location,
                   double latitude, double longitude, double rating, int ratingsCount, int completedJobs,
                   String status, String availability, String bio, String invitedBy) {
            this.name = name;
            this.phone = phone;
            this.email = email;
            this.skill = skill;
            this.experienceYears = experienceYears;
            this.location = location;
            this.latitude = latitude;
            this.longitude = longitude;
            this.rating = rating;
            this.ratingsCount = ratingsCount;
            this.completedJobs = completedJobs;
            this.status = status;
            this.availability = availability;
            this.bio = bio;
            this.invitedBy = invitedBy;
        }
    }
}

