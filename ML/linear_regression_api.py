import fastapi
from fastapi import FastAPI
from pydantic import BaseModel
import joblib
import uvicorn
import sklearn
import numpy
app=FastAPI()
class InputData(BaseModel):
    x1:float
    x2:float
model=joblib.load("linear_regression_model.pkl")
@app.post("/predict")
async def predict(data:InputData):
    x1=data.x1
    x2=data.x2
    input_data=numpy.array([[x1,x2]])
    prediction=model.predict(input_data)[0]
    return{"prediction":prediction}

if __name__=="__main__":
    uvicorn.run("linear_regression_api:app",host="localhost:8000")