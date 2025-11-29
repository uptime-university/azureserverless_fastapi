# app/main.py
from fastapi import FastAPI

app = FastAPI(title="My FastAPI on Azure Functions")

@app.get("/")
async def root():
    return {"message": "Hello from FastAPI on Azure Functions"}

# example endpoint
@app.get("/items/{item_id}")
async def read_item(item_id: int):
    return {"item_id": item_id}
