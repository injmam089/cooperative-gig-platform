# 🤝 Cooperative Gig Services Platform

### Smart India Hackathon 2026 · Problem Statement 26089

> **A cooperative-owned digital marketplace for household and community services — connecting customers with skilled workers, enabling booking and job tracking, supporting cooperative administration, and using AI-assisted workforce intelligence.**

[![Java](https://img.shields.io/badge/Java-17-orange?logo=openjdk&logoColor=white)](https://www.oracle.com/java/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.3.4-brightgreen?logo=springboot&logoColor=white)](https://spring.io/projects/spring-boot)
[![MySQL](https://img.shields.io/badge/MySQL-8.0%2B-blue?logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Python](https://img.shields.io/badge/Python-3.9%2B-blue?logo=python&logoColor=white)](https://www.python.org/)
[![FastAPI](https://img.shields.io/badge/FastAPI-ML%20Microservice-009688?logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com/)
[![Flutter](https://img.shields.io/badge/Flutter-Mobile%20App-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-Educational%20Prototype-lightgrey)](#license)

---

## 📌 Overview

**Cooperative Gig Services Platform** is a full-stack prototype built around **SIH Problem Statement 26089**. The platform is designed to create a digital service marketplace where customers can discover local services and workers, workers can manage availability and bookings, and administrators can monitor the platform and cooperative workforce.

The repository combines:

- A **Spring Boot 3 backend**
- **MySQL 8** persistence with JPA/Hibernate
- A browser-based **HTML/CSS/JavaScript frontend** served by Spring Boot
- A standalone **FastAPI + Scikit-Learn AI service**
- A **Flutter mobile application**
- Docker Compose orchestration for MySQL, backend, and AI services
- Seeded demo data for services, customers, workers, and bookings

The project is structured as a practical hackathon/academic prototype rather than a claim of a fully certified production marketplace.

---

## 🎯 Problem Statement

Labour Cooperative Societies and Federations have skilled workers across trades such as plumbing, electrical work, cleaning, carpentry, painting, driving, cooking, laundry, and construction. A digital platform can make these workers easier to discover while providing customers with a structured workflow for service requests, worker selection, booking status, notifications, ratings, and dispute handling.

### The platform aims to support

- Worker onboarding and profiles
- Skill-based service discovery
- Customer registration and authentication
- Worker availability management
- Service booking and scheduling
- Booking lifecycle tracking
- Worker verification workflows
- Ratings and reviews
- Complaints/disputes
- Notifications
- Administrative dashboards
- AI-assisted demand and workforce analysis
- Location-aware worker discovery
- Multilingual UI support
- Flutter mobile access

---

# ✨ Key Features

## 👤 Customer Experience

Customers can:

- Create an account
- Log in securely
- Verify email through OTP flows
- Browse service categories
- View worker profiles
- Search workers by skill
- Discover workers by city/locality
- Create service requests
- Select preferred date and time
- Track booking status
- Receive booking notifications
- Rate completed services
- Submit reviews
- Raise disputes/complaints
- View booking history

---

## 🧑‍🔧 Worker Portal

Workers can:

- Register with personal and professional information
- Add skill and experience details
- Maintain location information
- Log in using their credentials
- View their profile
- Manage availability
- Configure working schedules
- Receive booking notifications
- Accept/reject service requests
- Progress jobs through the supported lifecycle
- Track completed work
- Receive customer ratings

Worker passwords are hashed using **BCrypt** before persistence.

---

## 🏛️ Admin & Cooperative Management

The backend contains administrative functionality for:

- Dashboard metrics
- Worker listing
- Worker verification/status updates
- Customer listing
- Booking/service-request oversight
- Complaint/dispute monitoring
- Dispute resolution
- AI workforce intelligence
- Worker activation/standby workflows
- Platform-level operational analysis

The seeded data also contains an administrative/federation account for demonstration.

---

## 📅 Booking Lifecycle

The service-request layer implements server-side validation around a structured booking lifecycle:

```text
PENDING
   ↓
ASSIGNED
   ↓
ACCEPTED
   ↓
ON_THE_WAY
   ↓
STARTED / IN_PROGRESS
   ↓
COMPLETED
   ↓
PAID
   ↓
RATED
```

Alternative states include:

```text
CANCELLED
REJECTED
DISPUTED
```

The backend validates important transitions instead of allowing arbitrary status changes.

For example:

- A worker must accept a booking before marking it `ON_THE_WAY`.
- A job cannot be started directly from an invalid state.
- A completed/settled booking cannot simply be cancelled.
- Ratings are constrained to **1.0–5.0**.
- A worker can only update requests assigned to them when the authenticated worker context is supplied.

---

# 🧠 AI Workforce Intelligence

The project includes a separate Python microservice dedicated to workforce intelligence.

### Technology

- Python
- FastAPI
- NumPy
- Pandas
- Scikit-Learn
- Random Forest Regressor

### AI capabilities

The service supports:

- Demand forecasting
- Demand scoring
- Demand-level classification
- Workforce capacity analysis
- Shortage detection
- Workforce allocation recommendations
- Area/district-aware analysis
- Time-window analysis
- Worker recommendation data
- Explainable operational recommendations
- Model retraining endpoint

### Demand levels

```text
LOW
MODERATE
HIGH
CRITICAL
```

### AI service flow

```text
Platform Data
     │
     ├── Workers
     ├── Bookings
     └── Services
            │
            ▼
   FastAPI AI Service
            │
            ▼
 Random Forest Forecast
            │
            ▼
 Demand Score
            │
            ├── Demand Level
            ├── Workforce Gap
            ├── Shortage Detection
            └── Allocation Recommendation
```

The model currently trains against generated baseline/synthetic historical data and can also receive platform telemetry from the Spring Boot side.

---

# 📍 Location-Aware Worker Discovery

The backend stores worker and customer location information and includes latitude/longitude fields for workers.

The platform supports:

- City-based worker filtering
- Skill-based worker filtering
- Availability filtering
- Nearby-worker discovery
- Coordinate-aware distance calculations in workforce intelligence
- Area-specific demand analysis

The AI intelligence layer uses a **Haversine distance calculation** when ranking recommended workers by geographic proximity.

---

# 🔔 Notification System

The Spring Boot application contains a notification subsystem backed by database persistence.

Notifications are generated for events such as:

- New booking requests
- Booking acceptance
- Worker travelling to the customer
- Job started
- Job completed
- Booking rejection
- Customer ratings
- Disputes
- Administrative workforce actions

Available notification operations include:

```text
GET   /api/notifications
GET   /api/notifications/unread-count
PATCH /api/notifications/{id}/read
POST  /api/notifications/mark-all-read
```

---

# 🌐 Multilingual Interface

The web client includes runtime language support for:

- English
- हिन्दी (Hindi)

The language toggle is implemented in the frontend so the same application can be presented in both languages.

---

# 📱 Flutter Mobile Application

The repository contains a Flutter client under:

```text
mobile_app/
```

### Current mobile stack

- Flutter
- Dart
- HTTP
- Provider
- Shared Preferences
- Intl
- Cupertino Icons

The mobile application contains:

```text
mobile_app/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   └── models.dart
│   └── services/
│       └── api_service.dart
├── pubspec.yaml
└── README.md
```

The mobile client is designed to consume the backend REST API.

---

# 🏗️ System Architecture

```text
                         ┌──────────────────────────┐
                         │       Customer Web       │
                         │   HTML / CSS / JavaScript│
                         └────────────┬─────────────┘
                                      │
                                      │ REST
                                      ▼
┌──────────────────┐       ┌──────────────────────────┐
│ Flutter Mobile   │──────►│     Spring Boot 3       │
│ Application      │ REST  │       Backend           │
└──────────────────┘       │                          │
                           │ Controllers              │
                           │ Services                 │
                           │ Repositories             │
                           │ JPA / Hibernate          │
                           │ Security / Validation    │
                           └───────┬───────────┬──────┘
                                   │           │
                                   │           │ HTTP
                                   │           ▼
                                   │   ┌──────────────────┐
                                   │   │ FastAPI AI       │
                                   │   │ Workforce Engine  │
                                   │   │                  │
                                   │   │ Random Forest    │
                                   │   │ NumPy / Pandas   │
                                   │   └──────────────────┘
                                   │
                                   ▼
                         ┌─────────────────────┐
                         │      MySQL 8        │
                         │                     │
                         │ Customers           │
                         │ Workers             │
                         │ Services            │
                         │ Requests            │
                         │ Notifications       │
                         │ OTP records         │
                         └─────────────────────┘
```

---

# 🔄 Core Booking Data Flow

```text
Customer
   │
   ▼
Select Service
   │
   ▼
Find Worker
   │
   ▼
Choose Date / Time
   │
   ▼
Create Service Request
   │
   ▼
Spring Boot Validation
   │
   ├───────────────► MySQL
   │
   └───────────────► Notification
                         │
                         ▼
                       Worker
                         │
                         ▼
                  Accept / Reject
                         │
                         ▼
                  Job Status Updates
                         │
                         ▼
                    Completion
                         │
                         ▼
                    Customer Rating
                         │
                         ▼
                 Booking History
```

---

# 🧩 Backend Architecture

The Java application follows a layered architecture:

```text
Controller
    ↓
Service
    ↓
Repository
    ↓
JPA Entity
    ↓
MySQL
```

### Main backend layers

| Layer | Responsibility |
|---|---|
| Controllers | REST endpoints and request/response handling |
| DTOs | Input/output data transfer |
| Services | Business logic and workflows |
| Repositories | Database access |
| Models | JPA entities |
| Security | Password encoding, authentication configuration, CORS and authorization configuration |
| Exception Handler | Centralized API error handling |
| Initializer | Demo/service seed data |

---

# 📂 Project Structure

```text
cooperative-gig-platform/
│
├── pom.xml
├── mvnw
├── mvnw.cmd
├── Dockerfile
├── docker-compose.yml
├── schema.sql
├── .gitignore
│
├── database/
│   └── demo_seed_large.sql
│
├── ai_service/
│   ├── Dockerfile
│   ├── main.py
│   ├── model.py
│   ├── requirements.txt
│   └── README.md
│
├── mobile_app/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── models/
│   │   │   └── models.dart
│   │   └── services/
│   │       └── api_service.dart
│   ├── pubspec.yaml
│   └── README.md
│
└── src/
    ├── main/
    │   ├── java/com/sih/workerreg/
    │   │   ├── config/
    │   │   ├── controller/
    │   │   ├── dto/
    │   │   ├── exception/
    │   │   ├── model/
    │   │   ├── repository/
    │   │   ├── security/
    │   │   └── service/
    │   │
    │   └── resources/
    │       ├── application.properties
    │       └── static/
    │           ├── index.html
    │           ├── style.css
    │           └── app.js
    │
    └── test/
        ├── java/
        └── resources/
```

---

# 🛠️ Technology Stack

## Backend

| Technology | Purpose |
|---|---|
| Java 17 | Backend language |
| Spring Boot 3.3.4 | Application framework |
| Spring Web | REST API |
| Spring Data JPA | Persistence abstraction |
| Hibernate | ORM |
| Spring Validation | Request validation |
| Spring Security | Security configuration |
| BCrypt | Password hashing |
| JJWT 0.12.6 | JWT library dependency |
| Spring Mail | Transactional email / OTP support |
| MySQL Connector/J | MySQL connectivity |
| H2 | Automated test database |

> **Note:** The repository contains a JJWT dependency, while the current security configuration also uses HTTP session-based authentication for several application workflows. The README intentionally does not describe the platform as a JWT-only architecture.

## Frontend

- HTML5
- CSS3
- Vanilla JavaScript
- Responsive UI
- Runtime English/Hindi localization

## AI

- Python
- FastAPI
- Scikit-Learn
- RandomForestRegressor
- Pandas
- NumPy

## Mobile

- Flutter
- Dart
- Provider
- HTTP
- Shared Preferences
- Intl

## Database

- MySQL 8+
- JPA/Hibernate
- SQL seed scripts

## DevOps

- Docker
- Docker Compose
- Maven Wrapper
- Git/GitHub

---

# 🗃️ Database Model

The core relational model includes:

```text
customers
    │
    └──────────────┐
                   │
workers ───────────┼──► service_requests ◄── services
                   │
                   └──► notifications

otp_verifications
```

### Core entities

#### `customers`

Stores:

- Customer identity
- Phone
- Email
- Password hash
- Role
- Location
- Address
- Coordinates
- Creation timestamp

#### `workers`

Stores:

- Worker identity
- Contact information
- Skill
- Experience
- Location
- Latitude/longitude
- Availability
- Verification status
- Rating information
- Completed-job count
- Profile metadata

#### `services`

Stores:

- Service name
- Description
- Icon
- Pricing-related fields
- Active state

The seeded project contains ten service categories including:

```text
Plumbing
AC Repair & Maintenance
Cooking Services
Driver
Electrical Services
Cleaning Services
Carpenter
Painting
Mason / Construction
Laundry
```

#### `service_requests`

Stores:

- Customer
- Worker
- Service
- Description
- Location
- Preferred date/time
- Booking status
- Rating/review
- Timestamps
- Dispute information

#### `notifications`

Stores user-facing platform notifications.

#### `otp_verifications`

Stores OTP verification workflow data.

---

# 🔐 Security

The project includes several security-oriented components:

- Spring Security
- BCrypt password hashing
- Authentication services
- OTP verification flows
- Session-aware administrative operations
- Request validation
- Centralized exception handling
- CORS configuration
- Environment-based database configuration

### Important deployment rule

Do **not** commit real:

- Database passwords
- SMTP credentials
- API keys
- JWT secrets
- Production credentials

Use environment variables or a local `.env` configuration instead.

---

# 🔌 REST API

The backend exposes REST endpoints for the main platform modules.

## Customers

```http
POST /api/customers
POST /api/customers/login
POST /api/customers/logout
POST /api/customers/send-otp
POST /api/customers/verify-otp
GET  /api/customers
GET  /api/customers/{id}
GET  /api/customers/me
```

## Workers

```http
POST /api/workers
POST /api/workers/login
POST /api/workers/logout
GET  /api/workers
GET  /api/workers/{id}
GET  /api/workers/me
GET  /api/workers/nearby
PUT  /api/workers/{id}/availability
PUT  /api/workers/{id}/schedule
```

## Services

```http
GET /api/services
GET /api/services/{id}
```

## Service Requests

The booking module supports operations for:

```text
Create request
List requests
Get request by ID
Update lifecycle status
Rate service
Raise dispute
Resolve dispute
```

Representative routes include:

```http
POST /api/service-requests
GET  /api/service-requests
GET  /api/service-requests/{id}
POST /api/service-requests/{id}/rate
POST /api/service-requests/{id}/dispute
POST /api/service-requests/{id}/resolve-dispute
```

## Notifications

```http
GET   /api/notifications
GET   /api/notifications/unread-count
PATCH /api/notifications/{id}/read
POST  /api/notifications/mark-all-read
```

## Admin

```http
POST  /api/admin/login
POST  /api/admin/logout
GET   /api/admin/dashboard
GET   /api/admin/workers
GET   /api/admin/customers
GET   /api/admin/bookings
GET   /api/admin/complaints
PATCH /api/admin/workers/{id}/verify
```

## AI Workforce Intelligence

Spring Boot exposes AI-facing routes such as:

```http
GET  /api/ai/intelligence
GET  /api/workforce/predictions
GET  /api/admin/ai/intelligence
POST /api/workforce/activate-worker/{workerId}
POST /api/admin/ai/notify-worker/{workerId}
```

---

# 🤖 AI Service API

The standalone FastAPI service runs on port `8000`.

### Health

```http
GET /health
```

### Workforce Intelligence

```http
GET  /ai/workforce-intelligence
POST /ai/workforce-intelligence
```

### Demand Prediction

```http
GET /predict/demand
```

Example:

```text
/predict/demand
  ?category=Plumbing
  &district=Lucknow
  &dayOfWeek=6
  &hourOfDay=17
  &isEmergency=0
  &activeWorkers=8
```

### Workforce Allocation

```http
GET /predict/workforce-allocation
```

### Model Retraining

```http
POST /train
```

### Swagger UI

When the AI service is running:

```text
http://localhost:8000/docs
```

---

# 🚀 Quick Start

## Option 1 — Docker Compose

The easiest way to start the main infrastructure is:

```bash
git clone https://github.com/injmam089/cooperative-gig-platform.git
cd cooperative-gig-platform

docker compose up --build
```

Docker Compose starts:

```text
MySQL        → 3306 (internal container network)
AI Service   → http://localhost:8000
Backend      → http://localhost:8088
```

The backend waits for the MySQL health check before starting.

---

# ☕ Option 2 — Run Spring Boot Locally

## Prerequisites

Install:

- JDK 17+
- MySQL 8+
- Git
- Maven optional because the repository includes Maven Wrapper

### Clone

```bash
git clone https://github.com/injmam089/cooperative-gig-platform.git
cd cooperative-gig-platform
```

### Configure database

The application reads database configuration through environment variables.

Typical values:

```text
DB_HOST=localhost
DB_PORT=3306
DB_NAME=sih_db
DB_USERNAME=root
DB_PASSWORD=your_password
```

You can also configure the equivalent Spring datasource variables.

### Windows

```powershell
.\mvnw.cmd clean package
.\mvnw.cmd spring-boot:run
```

### Linux / macOS

```bash
chmod +x mvnw

./mvnw clean package
./mvnw spring-boot:run
```

### Open the application

```text
http://localhost:8088
```

---

# 🐍 Option 3 — Run AI Service Locally

```bash
cd ai_service
```

### Windows

```powershell
python -m venv venv
.\venv\Scripts\activate

pip install -r requirements.txt

uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

### Linux / macOS

```bash
python3 -m venv venv
source venv/bin/activate

pip install -r requirements.txt

uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

Then open:

```text
http://localhost:8000/docs
```

---

# 📱 Run the Flutter Application

Make sure Flutter is installed.

```bash
cd mobile_app

flutter pub get
flutter run
```

The mobile API base URL is configured in the Flutter API service and may need to be adjusted depending on whether the app is running on:

- Android emulator
- Physical Android device
- iOS simulator
- Local desktop environment

For a physical device, `localhost` refers to the device itself, so use the development machine's LAN IP where appropriate.

---

# 🧪 Testing

The backend includes automated tests under:

```text
src/test/
```

Run:

### Windows

```powershell
.\mvnw.cmd test
```

### Linux / macOS

```bash
./mvnw test
```

The repository contains an integration test covering seeded database behavior.

---

# 🧰 Useful Development Commands

### Build

```bash
./mvnw clean package
```

### Run

```bash
./mvnw spring-boot:run
```

### Test

```bash
./mvnw test
```

### AI service

```bash
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

### Docker

```bash
docker compose up --build
```

### Stop Docker services

```bash
docker compose down
```

### Remove database volume too

```bash
docker compose down -v
```

> `docker compose down -v` deletes the MySQL Docker volume and therefore removes the containerized database data.

---

# 🔑 Demo Accounts

The repository's `ServiceDataInitializer` seeds demonstration accounts.

| Role | Email | Password |
|---|---|---|
| Customer | `customer@example.com` | `Password@123` |
| Worker — Plumber | `rahul.plumber@example.com` | `Password@123` |
| Worker — Electrician | `amit.electric@example.com` | `Password@123` |
| Worker — Carpenter | `sanjay.carpenter@example.com` | `Password@123` |
| Admin/Federation | `admin@sih.gov.in` | `Admin@123` |

Additional seeded worker and customer accounts are created by the initializer.

> These credentials are for local/demo use only. Never reuse them in a real deployment.

---

# 🌱 Seeded Demo Dataset

The initializer prepares a realistic demo environment containing:

- 10 service categories
- 16 customer profiles
- 20 worker profiles
- Multiple worker skills and locations
- Verified and pending worker states
- Availability information
- Ratings and completed-job counts
- Multiple service requests across booking states
- Notification-ready workflows

This makes the application useful for:

- Hackathon demonstrations
- UI testing
- API testing
- Database demonstrations
- Admin dashboard demonstrations
- AI workforce intelligence demonstrations

---

# 💰 Cooperative Economic Model

The project concept describes a cooperative-oriented revenue distribution model in the current prototype documentation:

```text
85% → Worker earnings
 8% → Cooperative welfare
 7% → Platform operations
```

This should be understood as a **project/business-model concept represented in the prototype**, not as evidence of a live payment settlement system.

The current repository does not contain a production payment gateway implementation such as Razorpay/Stripe.

---

# 🧠 Why This Architecture?

### Why Spring Boot?

Spring Boot provides:

- Structured REST APIs
- Dependency injection
- JPA/Hibernate integration
- Validation
- Security integration
- Email support
- Test infrastructure
- Production-oriented Java backend patterns

### Why MySQL?

MySQL provides:

- Relational integrity
- Foreign keys
- Structured service/customer/worker relationships
- Familiar SQL tooling
- Straightforward local and Docker deployment

### Why FastAPI?

FastAPI isolates the ML workload from the Java application.

Benefits:

- Python ML ecosystem
- Independent model lifecycle
- Easy API integration
- Interactive Swagger documentation
- Clear separation between business services and ML inference

### Why Random Forest?

The prototype uses `RandomForestRegressor` because it can model non-linear relationships between categorical/time/workforce features without requiring a deep-learning stack.

### Why Flutter?

Flutter provides a single mobile codebase for a future/parallel mobile client while allowing the same backend APIs to serve multiple clients.

---

# 🔐 Configuration

The backend uses environment-driven configuration for database and email settings.

Important variables include:

```text
DB_HOST
DB_PORT
DB_NAME

DB_USERNAME
DB_PASSWORD

SPRING_DATASOURCE_URL
SPRING_DATASOURCE_USERNAME
SPRING_DATASOURCE_PASSWORD

MAIL_HOST
MAIL_PORT
MAIL_USERNAME
MAIL_PASSWORD
MAIL_FROM
MAIL_FROM_NAME
MAIL_ENABLED
```

For local development, create your own `.env`/environment configuration and keep secrets out of Git.

---

# 🐳 Docker Architecture

```text
                 Docker Compose
                       │
        ┌──────────────┼───────────────┐
        │              │               │
        ▼              ▼               ▼
   ┌─────────┐   ┌────────────┐   ┌─────────────┐
   │ MySQL 8 │   │ Spring Boot│   │ FastAPI AI  │
   │         │◄──│ Backend    │──►│ Service     │
   └────┬────┘   └─────┬──────┘   └─────────────┘
        │              │
        │              ▼
        │         Web Application
        │         :8088
        │
        └──── Persistent Volume
```

Services defined in `docker-compose.yml`:

```text
mysql-db
backend
ai-service
```

---

# 📊 Current Implementation vs Future Scope

The repository is intentionally a prototype, so some SIH-level capabilities are represented at different implementation stages.

## Implemented / represented in the repository

- Spring Boot REST backend
- MySQL persistence
- JPA/Hibernate entities and repositories
- Customer registration/login
- Worker registration/login
- BCrypt password hashing
- OTP/email infrastructure
- Service catalogue
- Worker search/filtering
- Location-aware worker discovery
- Booking creation
- Booking status lifecycle validation
- Notifications
- Ratings/reviews
- Disputes and admin resolution
- Admin dashboard APIs
- AI workforce intelligence service
- FastAPI ML service
- Random Forest demand forecasting
- Flutter application skeleton
- English/Hindi frontend localization
- Docker Compose infrastructure
- Seeded demo data
- Automated backend tests

## Potential future extensions

- Production payment gateway integration
- Real escrow/settlement infrastructure
- Fully enforced multi-tenant cooperative/federation hierarchy
- Stronger API authorization boundaries
- Production-grade JWT authentication flow across all clients
- Real-world workforce demand telemetry instead of synthetic baseline data
- Persistent trained ML model/versioning
- Advanced map UI and live location tracking
- Cloud object storage for worker documents
- Document/KYC verification workflows
- Production push notification infrastructure
- CI/CD pipelines
- Observability and audit logging
- Automated security scanning
- Production deployment hardening

---

# 🧪 Example: Create a Service Request

A simplified request can look like:

```json
{
  "customerId": 1,
  "workerId": 1,
  "serviceId": 1,
  "description": "Kitchen sink leakage repair",
  "location": "Gomti Nagar, Lucknow",
  "preferredDate": "2026-10-05",
  "preferredTime": "10:00 AM - 12:00 PM"
}
```

The backend then:

```text
Validate customer
      ↓
Validate worker
      ↓
Validate service
      ↓
Check booking constraints
      ↓
Create PENDING request
      ↓
Persist to MySQL
      ↓
Create customer/worker notifications
```

---

# 📈 AI Demand Example

Example request:

```http
GET /predict/demand?category=Plumbing&district=Lucknow&dayOfWeek=6&hourOfDay=17&isEmergency=0&activeWorkers=8
```

The service returns information including:

```json
{
  "category": "Plumbing",
  "district": "Lucknow",
  "demandScore": 72,
  "demandLevel": "HIGH",
  "rawDemandUnits": 27.4,
  "projectedWeeklyVolume": 173
}
```

> Example values above are illustrative. Actual output is generated by the model at runtime.

---

# 🧭 Project Workflow

```text
                 ┌──────────────────┐
                 │ Customer / Worker│
                 └────────┬─────────┘
                          │
                          ▼
                  Authentication
                          │
              ┌───────────┴───────────┐
              │                       │
              ▼                       ▼
        Service Discovery       Worker Management
              │                       │
              └───────────┬───────────┘
                          ▼
                   Service Booking
                          │
                          ▼
                  Booking Lifecycle
                          │
            ┌─────────────┼─────────────┐
            ▼             ▼             ▼
      Notifications     Rating       Dispute
            │             │             │
            └─────────────┴─────────────┘
                          │
                          ▼
                    Admin Analytics
                          │
                          ▼
                 AI Workforce Engine
                          │
                          ▼
              Demand / Shortage Insight
```

---

# 🧑‍💻 Development Principles

The codebase emphasizes:

- Layered architecture
- Separation of DTOs and entities
- Service-oriented business logic
- Repository abstraction
- Database-backed workflows
- Input validation
- BCrypt password hashing
- Centralized exception handling
- Environment-based configuration
- Modular AI service separation
- Reusable REST APIs
- Mobile/backend separation

---

# 🛡️ Security Notes

This is a hackathon/academic prototype. Before production use, the following areas should receive additional hardening:

- Strict endpoint authorization
- CSRF/session strategy review
- Production CORS allowlists
- Rate limiting
- Brute-force protection
- Secure secret management
- HTTPS enforcement
- Security headers
- Audit trails
- PII minimization
- Input/output security review
- Dependency vulnerability scanning
- Production database permissions
- Secure email/OTP lifecycle
- Payment security and reconciliation

---

# 🗺️ Roadmap

```text
[x] Core Spring Boot backend
[x] MySQL persistence
[x] Customer workflows
[x] Worker workflows
[x] Service catalogue
[x] Booking lifecycle
[x] Notifications
[x] Ratings and disputes
[x] Admin APIs
[x] AI workforce intelligence
[x] FastAPI ML microservice
[x] Flutter client foundation
[x] Docker Compose setup
[x] Demo seed dataset

[ ] Production payment integration
[ ] Stronger multi-cooperative tenancy
[ ] Production-grade authorization model
[ ] Persistent ML model/version registry
[ ] Cloud deployment
[ ] CI/CD
[ ] Production push notifications
[ ] Advanced observability
[ ] Security audit and penetration testing
```

---

# 🎓 Academic / Hackathon Value

This project demonstrates practical experience with:

- Full-stack application architecture
- REST API design
- Java Spring Boot
- Relational database design
- ORM with JPA/Hibernate
- Authentication and password security
- OTP workflows
- Service booking systems
- State-machine-style workflow validation
- Notifications
- Admin analytics
- AI/ML integration
- Microservice architecture
- Python FastAPI
- Flutter mobile development
- Docker containerization
- Git/GitHub workflows

---

# 🤝 Suggested Team Responsibilities

A four-member implementation team can divide work as:

| Role | Primary Area |
|---|---|
| Member 1 | Spring Boot backend, REST APIs, database |
| Member 2 | Frontend, UX, localization, responsive UI |
| Member 3 | AI/ML service, forecasting, workforce intelligence |
| Member 4 | Flutter app, testing, integration, documentation |

All members can contribute to:

- Architecture
- Testing
- Demo preparation
- Documentation
- Presentation
- Deployment

---

# 🧑‍🔬 Demo Flow

For a strong project demonstration:

### 1. Customer

```text
Login
 ↓
Browse services
 ↓
Find a worker
 ↓
Create booking
```

### 2. Worker

```text
Worker login
 ↓
Receive notification
 ↓
Accept booking
 ↓
Update job status
 ↓
Complete service
```

### 3. Customer

```text
View completion
 ↓
Rate worker
 ↓
Submit review
```

### 4. Admin

```text
Open dashboard
 ↓
Review workers
 ↓
Review bookings
 ↓
Inspect complaints
 ↓
Open AI workforce intelligence
```

### 5. AI

```text
Select area/time
 ↓
Generate demand intelligence
 ↓
Detect workforce gap
 ↓
Recommend nearby worker activation
```

---

# ⚠️ Prototype Disclaimer

This repository is a **Smart India Hackathon / academic prototype**.

It should not be interpreted as a fully deployed government or production cooperative marketplace without additional:

- Security review
- Legal/compliance review
- Payment compliance
- Privacy controls
- Infrastructure hardening
- Operational monitoring
- Cooperative governance implementation
- Load and reliability testing
- Independent validation of AI outputs

AI forecasts and workforce recommendations should be treated as decision-support outputs, not guaranteed predictions.

---

# 📄 License

This repository is intended primarily for **educational, academic, hackathon, and portfolio use**.

If you plan to reuse the project commercially, review the repository dependencies, third-party licenses, data/privacy requirements, and the project's final licensing terms before deployment.

---

# 👨‍💻 Author

**Injmam**

GitHub:  
https://github.com/injmam089

Repository:  
https://github.com/injmam089/cooperative-gig-platform

---

## ⭐ If you find the project useful

Consider giving the repository a ⭐ on GitHub and using it as a reference for learning:

**Spring Boot + MySQL + REST APIs + AI/ML + Flutter + Docker**

---

<p align="center">
  <b>Cooperative Gig Services Platform</b><br>
  Smart India Hackathon 2026 · Problem Statement 26089
</p>
