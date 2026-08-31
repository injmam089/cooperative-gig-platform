# 📱 Cooperative Gig Platform - Flutter Mobile Application
## SIH 2026 Problem Statement 26089

A production-quality cross-platform Flutter application for **Customers, Workers, and Society Administrators**, consuming Spring Boot 3 REST APIs and Python AI forecasting services.

---

### Key Capabilities
- **Customer Mode**: Instant category discovery, verified worker cards with star ratings & experience badges, seamless booking modal with fair wage breakdown, and real-time status tracking.
- **Worker Mode**: Profile management, incoming booking requests, earnings counter (85% worker guarantee), status transitions (`ACCEPTED` $\rightarrow$ `STARTED` $\rightarrow$ `COMPLETED`).
- **Cooperative & AI Mode**: Real-time surge forecasts and explainable workforce deficit rebalancing alerts.

---

### How to Run

1. Ensure Flutter 3.x+ is installed:
   ```bash
   flutter doctor
   ```

2. Navigate to this directory and fetch dependencies:
   ```bash
   cd d:\SIH\mobile_app
   flutter pub get
   ```

3. Run on Android Emulator, iOS Simulator, or Chrome:
   ```bash
   flutter run -d chrome
   # or for connected Android device/emulator:
   flutter run
   ```
