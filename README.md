# 🤝 Cooperative Gig Services Platform — Local Community Marketplace

A clean, user-friendly, and accessible local service marketplace built for the **Smart India Hackathon (SIH)**. The platform connects trusted local trade workers (plumbers, electricians, carpenters, cooks, drivers, etc.) directly with customers with fair cooperative pricing and zero unfair platform commissions.

---

## 🌟 Human-Centric Customer & Worker Experience

### For Customers:
$$\text{Home / Search} \xrightarrow{\text{Choose Service}} \text{Find Local Workers} \xrightarrow{\text{Browse Verified Profiles}} \text{Request Service} \xrightarrow{\text{Confirmation}}$$

### For Workers:
$$\text{Join as Worker} \xrightarrow{\text{Add Personal Info \& Trade}} \text{Select Experience} \xrightarrow{\text{Submit Profile}} \text{Receive Local Bookings}$$

---

## 🧭 Public Navigation & Information Architecture

- **Home**: Clean hero section with *"Need help at home?"*, quick service search bar, popular service chips, visual *"How It Works"* guides, and core cooperative value pillars.
- **Find a Service**: Visual marketplace cards with large icons and descriptions (Plumbing, Electrical, AC Repair, Cleaning, Carpenter, Painting, Driver, Cooking, Mason, Laundry).
- **How It Works**: Step-by-step visual roadmap for both customers and workers.
- **Sign Up**: Friendly 2-step customer account registration with BCrypt password hashing.
- **Join as Worker**: Streamlined worker onboarding with context-aware service pre-fill and experience selector.
- **Admin & Developer Dashboard**: Dedicated admin section accessible via the footer with live metrics, tabbed tables, and MySQL inspection query view.

---

## 📁 Project Structure

```
d:/SIH/
├── pom.xml                               # Spring Boot 3 & dependencies
├── schema.sql                            # Complete MySQL schema & seed data
├── mvnw & mvnw.cmd                       # Maven Wrapper executables
├── .mvn/wrapper/                         # Wrapper configuration
├── src/
│   ├── main/
│   │   ├── java/com/sih/workerreg/
│   │   │   ├── WorkerRegistrationApplication.java  # Main application entry point
│   │   │   ├── config/
│   │   │   │   └── ServiceDataInitializer.java    # Auto-seeds 10 services in MySQL
│   │   │   ├── model/
│   │   │   │   ├── Worker.java                    # 'workers' table
│   │   │   │   ├── Customer.java                  # 'customers' table
│   │   │   │   ├── ServiceItem.java               # 'services' table
│   │   │   │   └── ServiceRequest.java            # 'service_requests' table
│   │   │   ├── dto/
│   │   │   │   ├── WorkerRegistrationDto.java
│   │   │   │   ├── CustomerSignUpDto.java
│   │   │   │   ├── CustomerResponseDto.java
│   │   │   │   ├── CreateServiceRequestDto.java
│   │   │   │   └── ServiceRequestResponseDto.java
│   │   │   ├── repository/
│   │   │   │   ├── WorkerRepository.java
│   │   │   │   ├── CustomerRepository.java
│   │   │   │   ├── ServiceRepository.java
│   │   │   │   └── ServiceRequestRepository.java
│   │   │   ├── service/
│   │   │   │   ├── WorkerService.java
│   │   │   │   ├── CustomerService.java
│   │   │   │   ├── ServiceService.java
│   │   │   │   └── ServiceRequestService.java
│   │   │   ├── controller/
│   │   │   │   ├── WorkerController.java
│   │   │   │   ├── CustomerController.java
│   │   │   │   ├── ServiceController.java
│   │   │   │   └── ServiceRequestController.java
│   │   │   └── exception/
│   │   │       └── GlobalExceptionHandler.java
│   │   └── resources/
│   │       ├── application.properties             # Database connection settings
│   │       └── static/
│   │           ├── index.html                     # Accessible, human-friendly HTML5
│   │           ├── style.css                      # Modern responsive design system
│   │           └── app.js                         # REST API integration & search controller
└── README.md
```

---

## 🚀 How to Run

1. Verify your MySQL credentials in [`src/main/resources/application.properties`](file:///d:/SIH/src/main/resources/application.properties):
   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3307/sih_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&createDatabaseIfNotExist=true
   spring.datasource.username=root
   spring.datasource.password=Injmam@089
   ```

2. Start the application:
   ```powershell
   $env:JAVA_HOME = "C:\Program Files\Java\jdk-25.0.2"; .\mvnw.cmd spring-boot:run
   ```

3. Open **[http://localhost:8080](http://localhost:8080)** in your browser.

---

## 🧪 Testing the User Flows

### 1. Customer Flow (Find Service $\rightarrow$ Search $\rightarrow$ Book)
1. Open **[http://localhost:8080](http://localhost:8080)**.
2. In the hero search box, choose **"Plumbing"**, enter location **"Bangalore"**, and click **Find Workers**.
3. View available verified plumbers with ratings and experience.
4. Click **Request Service**, select your customer account, pick a date & time slot, and confirm.

### 2. Worker Flow (Join as Worker $\rightarrow$ Profile Created $\rightarrow$ Instant Discovery)
1. Click **Join as Worker** in the navigation.
2. Enter your details, choose your service trade (e.g. **Driver**), select experience (e.g. **3–5 years**), enter city, and click **Register as a Worker**.
3. View the confirmation card and click **🔍 View in Driver Services** to immediately see your worker profile active in the marketplace!

### 3. Admin / Database Inspector
1. Click **⚙️ Admin / Database View** in the footer.
2. View real-time database counts, live records across all 4 MySQL tables, and SQL query inspection.
