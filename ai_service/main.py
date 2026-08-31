from fastapi import FastAPI, Query, HTTPException, Body
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional, Dict, Any
import uvicorn
from model import CooperativeDemandForecastModel

app = FastAPI(
    title="Cooperative Gig Platform - AI Workforce Intelligence Service",
    description="Python FastAPI Microservice providing ML-powered demand forecasting, shortage detection, and smart cooperative workforce allocation for SIH 2026 Problem Statement 26089.",
    version="2.0.0"
)

# Enable CORS for Spring Boot & Frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize ML Model
ai_engine = CooperativeDemandForecastModel()

class RetrainRequest(BaseModel):
    samples: Optional[int] = 1000

class TelemetryPayload(BaseModel):
    area: Optional[str] = "All Areas"
    timeWindow: Optional[str] = "CURRENT"
    mode: Optional[str] = "LIVE_TELEMETRY"
    workers: Optional[List[Dict[str, Any]]] = []
    bookings: Optional[List[Dict[str, Any]]] = []
    services: Optional[List[Dict[str, Any]]] = []

@app.get("/health")
def health_check():
    return {
        "status": "HEALTHY",
        "service": "Cooperative AI Workforce Intelligence Engine",
        "modelTrained": ai_engine.is_trained,
        "engine": "Scikit-Learn RandomForest + NumPy + Pandas",
        "version": "2.0.0",
        "features": ["0-100% Demand Scoring", "Capacity Gap Detection", "Smart Worker Ranking", "Explainable Directives"]
    }

@app.get("/ai/workforce-intelligence")
def get_workforce_intelligence(
    area: str = Query("All Areas", description="District or sector"),
    timeWindow: str = Query("CURRENT", description="Time window (CURRENT, NEXT_1H, NEXT_3H, PEAK_TODAY, TOMORROW)"),
    mode: str = Query("LIVE_TELEMETRY", description="Operation mode (LIVE_TELEMETRY, DEMO_SCENARIO)")
):
    """
    Consolidated AI Workforce Intelligence analysis endpoint (GET query based).
    """
    try:
        is_demo = (mode.upper() == "DEMO_SCENARIO")
        result = ai_engine.compute_workforce_intelligence(
            area=area,
            time_window=timeWindow,
            live_data=None,
            is_demo_mode=is_demo
        )
        return result
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/ai/workforce-intelligence")
def post_workforce_intelligence(payload: TelemetryPayload):
    """
    Consolidated AI Workforce Intelligence analysis endpoint accepting live Spring Boot DB telemetry.
    """
    try:
        is_demo = (payload.mode and payload.mode.upper() == "DEMO_SCENARIO")
        live_data = {
            "workers": payload.workers or [],
            "bookings": payload.bookings or [],
            "services": payload.services or []
        }
        result = ai_engine.compute_workforce_intelligence(
            area=payload.area or "All Areas",
            time_window=payload.timeWindow or "CURRENT",
            live_data=live_data,
            is_demo_mode=is_demo
        )
        return result
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/predict/demand")
def predict_demand(
    category: str = Query("Plumbing", description="Service category name"),
    district: str = Query("Lucknow", description="District or municipal zone"),
    dayOfWeek: int = Query(6, ge=1, le=7, description="1=Monday, 7=Sunday"),
    hourOfDay: int = Query(17, ge=0, le=23, description="Hour of day (0-23)"),
    isEmergency: int = Query(0, ge=0, le=1, description="1 if emergency rush, 0 otherwise"),
    activeWorkers: int = Query(8, ge=1, description="Currently active worker count")
):
    """
    Returns non-linear ML-predicted demand forecasts with 0-100% Demand Score.
    """
    try:
        prediction = ai_engine.predict_demand(
            category=category,
            district=district,
            day_of_week=dayOfWeek,
            hour_of_day=hourOfDay,
            is_emergency=isEmergency,
            active_workers=activeWorkers
        )
        return prediction
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/predict/workforce-allocation")
def predict_workforce_allocation(
    category: str = Query("Plumbing", description="Trade category"),
    district: str = Query("Gomti Nagar, Lucknow", description="Operational sector"),
    availableWorkers: int = Query(12, ge=0, description="Available registered workers in sector")
):
    """
    Computes explainable workforce rebalancing recommendations based on predicted demand vs local supply.
    """
    try:
        recommendation = ai_engine.recommend_workforce_allocation(
            category=category,
            district=district,
            available_workers=availableWorkers
        )
        return recommendation
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/train")
def retrain_model(request: RetrainRequest):
    """
    Retrains the Random Forest Regressor on refreshed telemetry data.
    """
    try:
        ai_engine.train_baseline_model()
        return {
            "success": True,
            "message": "AI Forecasting Model retrained successfully.",
            "estimator": "RandomForestRegressor(n_estimators=100)"
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
