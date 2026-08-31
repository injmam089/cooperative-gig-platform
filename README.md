# 🤝 Cooperative Gig Services Platform
## Smart India Hackathon (SIH) 2026 — Problem Statement 26089
### *“Cooperative Gig Services Platform for Household & Community Services”*

A production-quality cooperative digital service marketplace connecting customers with verified skilled workers belonging to Labour Cooperative Societies/Federations.

---

## 🌟 Core Pillars & Key Features

1. **🏛️ Cooperative Ownership & Fair Wage Model**:
   - **85%** direct worker earnings guarantee.
   - **8%** cooperative welfare fund allocation (pensions, accidental insurance).
   - **7%** operational platform maintenance.
   - Zero predatory commission extraction.

2. **🛡️ 4-Tier Role-Based Security (Spring Security 6 + JWT)**:
   - `CUSTOMER` — Search, geo-match, book normal/emergency services, track jobs, sandbox payment, transparent invoices, ratings & complaints.
   - `WORKER` — Profile, skill certifications, availability scheduling, job acceptance, live status transitions, earnings tracker.
   - `SOCIETY_ADMIN` — Local cooperative worker approval/rejection pipeline, dispute mediation, welfare scheme enrollment.
   - `FEDERATION_ADMIN` — State-wide macro KPIs, multi-society governance, workforce recommendations, demand forecasting.

3. **📍 Deterministic Geo-Spatial Matching Engine**:
   - Multi-factor weighted candidate scoring:
     $$\text{Match Score} = 0.40 \cdot \text{Skill} + 0.25 \cdot \text{Distance} + 0.15 \cdot \text{Availability} + 0.10 \cdot \text{Rating} + 0.10 \cdot \text{Experience}$$
   - Haversine great-circle distance algorithm for proximity filtering.

4. **🚨 Urgent / Emergency Service Dispatch**:
   - One-tap priority dispatch locating nearest available verified trade worker with 15-30 min response target.

5. **🧠 AI/ML Demand Forecasting & Workforce Allocation**:
   - Standalone **Python FastAPI** microservice using **Scikit-Learn (Random Forest Regressor)**.
   - Predictive demand forecasts and explainable workforce rebalancing directives across neighboring cooperative societies.

6. **📱 Cross-Platform Flutter Mobile Application**:
   - Native Flutter client for Customers, Workers, and Admins consuming the REST API.

7. **🌐 Multilingual Localization**:
   - Instant runtime language toggle between **English** and **हिन्दी (Hindi)**.

---

## 📁 Full System Architecture

```
cooperative-gig-platform/
├── pom.xml                               # Spring Boot 3 dependencies (Security, Validation, JPA)
├── .env.example                          # Cross-OS environment configuration template
├── Dockerfile                            # Multi-stage Spring Boot container
├── docker-compose.yml                    # Multi-container orchestration (MySQL + Backend + AI)
├── mvnw & mvnw.cmd                       # Cross-OS Maven Wrapper (Linux, macOS, Windows)
├── schema.sql                            # Portable MySQL 8+ DDL & initial seed script
│
├── src/main/java/com/sih/workerreg/
│   ├── WorkerRegistrationApplication.java# Spring Boot main entrypoint & portable .env loader
│   ├── config/
│   │   └── ServiceDataInitializer.java   # Auto-seeds realistic demo cooperatives & workers
│   ├── security/
│   │   └── SecurityConfig.java           # Spring Security 6, session auth & universal CORS
│   ├── model/                            # JPA Entities (Customer, Worker, ServiceItem, Request, etc.)
│   ├── repository/                       # Spring Data JPA repositories
│   ├── service/                          # Core business logic, Geo-matching, OTP & Notifications
│   └── controller/                       # REST API controllers
│
├── src/main/resources/
│   ├── application.properties            # Environment-driven Spring configuration
│   └── static/
│       ├── index.html                    # Single-Page Application (Customer, Worker, Admin)
│       ├── style.css                     # Responsive CSS Design System
│       └── app.js                        # Dynamic frontend controller & API client
│
├── ai_service/                           # Python FastAPI AI Microservice
│   ├── main.py                           # FastAPI application endpoints
│   ├── model.py                          # Scikit-Learn RandomForest demand forecaster
│   ├── requirements.txt                  # Python dependencies
│   ├── Dockerfile                        # AI container
│   └── README.md                         # AI service documentation
│
└── mobile_app/                           # Flutter Mobile Application
    ├── lib/main.dart                     # Flutter application entrypoint & UI
    ├── lib/models/models.dart            # Flutter data models
    ├── lib/services/api_service.dart     # HTTP REST client
    ├── pubspec.yaml                      # Flutter dependencies
    └── README.md                         # Mobile app guide
```

---

## 🚀 How to Run the Platform (Cross-OS Guide)

### Prerequisites
- **Java**: JDK 17, 21, or 25 installed.
- **MySQL**: MySQL 8.0+ or MariaDB running on port 3306 or 3307.
- **Python (Optional)**: Python 3.9+ for AI Forecasting service.
- **Docker (Optional)**: Docker & Docker Compose for containerized startup.

---

### 1. Spring Boot Backend Setup

#### 🪟 Windows (PowerShell or Command Prompt)
```powershell
# 1. (Optional) Copy configuration template
Copy-Item .env.example .env

# 2. Build and run using the Windows Maven Wrapper
.\mvnw.cmd clean package
.\mvnw.cmd spring-boot:run
```
*Or with explicit environment variables in PowerShell:*
```powershell
$env:DB_USERNAME = "root"
$env:DB_PASSWORD = "your_mysql_password"
.\mvnw.cmd spring-boot:run
```

#### 🐧 Linux (Ubuntu / Debian / Fedora)
```bash
# 1. (Optional) Copy configuration template
cp .env.example .env

# 2. Ensure Maven Wrapper has execute permissions
chmod +x mvnw

# 3. Build and run using the Linux Maven Wrapper
./mvnw clean package
./mvnw spring-boot:run
```
*Or with explicit inline environment variables in Bash:*
```bash
DB_USERNAME=root DB_PASSWORD=your_password ./mvnw spring-boot:run
```

#### 🍎 macOS (Terminal / Zsh)
```zsh
# 1. (Optional) Copy configuration template
cp .env.example .env

# 2. Ensure Maven Wrapper has execute permissions
chmod +x mvnw

# 3. Build and run using the macOS Maven Wrapper
./mvnw clean package
./mvnw spring-boot:run
```

- 🌐 **Web Application Portal**: **[http://localhost:8088](http://localhost:8088)**
- 📡 **REST API Base**: **[http://localhost:8088/api/workers](http://localhost:8088/api/workers)**

---

### 2. Python AI Forecasting Microservice

#### 🪟 Windows
```powershell
cd ai_service
python -m venv venv
.\venv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

#### 🐧 Linux / 🍎 macOS
```bash
cd ai_service
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```
- 📄 **Interactive Swagger API Documentation**: **[http://localhost:8000/docs](http://localhost:8000/docs)**

---

### 3. Docker Compose (Universal 1-Command Startup)

Works identically on Windows, Linux, and macOS:
```bash
docker compose up --build
```
This automatically boots MySQL 8.0, the Spring Boot backend, and the Python AI forecasting microservice in isolated bridge networks with persistent volume storage.

---

## 🧪 Demo Login Credentials

| Role | Email | Password |
|---|---|---|
| **Customer** | `customer@example.com` | `Password@123` |
| **Verified Plumber (Rahul)** | `rahul.plumber@example.com` | `Password@123` |
| **Verified Electrician (Amit)** | `amit.electric@example.com` | `Password@123` |
| **Verified Carpenter (Sanjay)** | `sanjay.carpenter@example.com` | `Password@123` |
| **Society Admin (Sunita)** | `society.admin@example.com` | `Password@123` |
| **Federation Admin (Rajendra)** | `federation.admin@example.com` | `Password@123` |

---

## 🔬 Automated Tests

Execute the automated test suite across any operating system:

- **Windows**: `.\mvnw.cmd test`
- **Linux / macOS**: `./mvnw test`

---

## 🔧 Troubleshooting Common Startup Issues

1. **Port 8088 already in use**:
   - Change `SERVER_PORT=8089` or `PORT=8089` in your `.env` file or export `SERVER_PORT=8089`.
2. **MySQL Connection Refused / Access Denied**:
   - Check if your MySQL server is running on port 3306 (standard Linux/macOS) or 3307 (custom Windows setup).
   - Configure `SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3306/sih_db?...` in `.env`.
3. **`mvnw: Permission denied` on Linux/macOS**:
   - Run `chmod +x mvnw` once before executing.
4. **`JAVA_HOME` not set**:
   - Ensure a modern JDK (17+) is installed. On macOS: `export JAVA_HOME=$(/usr/libexec/java_home -v 17)`. On Linux: `export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64`.
