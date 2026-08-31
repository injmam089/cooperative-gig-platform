# 🧠 AI Demand Forecasting & Workforce Allocation Service
## Cooperative Gig Services Platform (SIH 2026 Problem Statement 26089)

A standalone Python microservice using **FastAPI, Scikit-Learn, Pandas, and NumPy** for demand forecasting and workforce rebalancing recommendations.

---

### Features
1. **Machine Learning Demand Forecaster**: Multi-feature `RandomForestRegressor` incorporating service category, municipal district, temporal factors (day of week, hour of day), emergency weighting, and current worker density.
2. **Workforce Allocation Optimizer**: Detects localized deficit gaps and outputs explainable reallocation directives across cooperative societies.
3. **RESTful Integration**: Seamlessly consumed by Spring Boot at `/api/ai/*`.

---

### How to Run

1. Navigate to this directory:
   ```bash
   cd d:\SIH\ai_service
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Launch the FastAPI server on port 8000:
   ```bash
   uvicorn main:app --host 0.0.0.0 --port 8000 --reload
   ```

4. Interactive Swagger UI Documentation:
   - Open **[http://localhost:8000/docs](http://localhost:8000/docs)**
