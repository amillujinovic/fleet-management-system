import fastapi
from fastapi import FastAPI
from pydantic import BaseModel
import joblib
import numpy as np
from pathlib import Path
from typing import Optional, List
app=FastAPI()
model = joblib.load(Path(__file__).parent / "obd_isolation_forest.pkl")
class ObdInput(BaseModel):
    rpm:float
    speed:float
    engine_temp:float
    engine_load:float
    fuel_level:float
class PredictionOutput(BaseModel):
    anomaly_score:float
    is_anomaly:bool
class ObdReadingItem(BaseModel):
    rpm: Optional[float] = None
    speed: Optional[float] = None
    engine_temp: Optional[float] = None
    engine_load: Optional[float] = None
    fuel_level: Optional[float] = None
class TrendRequest(BaseModel):
    readings: List[ObdReadingItem]
class TrendOutput(BaseModel):
    warnings: List[str]
    trends: dict
@app.post("/predict",response_model=PredictionOutput)
def predict(data:ObdInput):
    input_array=np.array([[
        data.rpm,
        data.speed,
        data.engine_temp,
        data.engine_load,
        data.fuel_level
    ]])
    score=float(model.decision_function(input_array)[0])
    is_anomaly=bool(model.predict(input_array)[0]==-1)
    return PredictionOutput(anomaly_score=score,is_anomaly=is_anomaly)
@app.get("/health")
def health():
    return{"Status":"Ok"}
@app.post("/trend")
def analyze_trend(data:TrendRequest):
    warnings=[]
    trends={}
    temps=[r.engine_temp for r in data.readings if r.engine_temp is not None]
    rpms=[r.rpm for r in data.readings if r.rpm is not None]
    loads=[r.engine_load for r in data.readings if r.engine_load is not None]
    fuels=[r.fuel_level for r in data.readings if r.fuel_level is not None]
    if len(temps)>3:
        slope=float(np.polyfit(range(len(temps)),temps,1)[0])
        trends["engine_temp_slope"]=round(slope,3)
        if slope>0.5 and temps[-1]>88:
            warnings.append(f"Engine temperature is raising({slope:.1f}°C every reading-check cooling system!)")

    if len(rpms)>3:
        slope=float(np.polyfit(range(len(rpms)),rpms,1)[0])
        trends["rpmm_slope"]=round(slope,3)
        avg_rpm = sum(rpms) / len(rpms)
        if slope>50 and rpms[-1]>3000:
                warnings.append(f"RPM is constantly raising({slope:.0f}RPM every reading-check it!)")
        elif avg_rpm > 5000:  
            warnings.append(
            f"RPM consistently high (avg {avg_rpm:.0f}) — check engine load!")
    if len(loads)>3:
        slope=float(np.polyfit(range(len(loads)),loads,1)[0])
        trends["engine_load_slope"]=round(slope,3)
        if slope>1.5 and loads[-1]>70:
            warnings.append(f"Engine load is raising({slope:.1f}% every reading!)")
    if len(fuels)>3:
        slope=float(np.polyfit(range(len(fuels)),fuels,1)[0])
        trends["fuel_slope"]=round(slope,3)
        if slope < -1.0 and fuels[-1] < 30:
            warnings.append(
                f"Fuel is consumed quickly ({abs(slope):.1f}% every reading) — fuel tank!"
            )
    if not warnings:
        warnings.append("All values ​​in a stable trend")

    return TrendOutput(warnings=warnings, trends=trends)   