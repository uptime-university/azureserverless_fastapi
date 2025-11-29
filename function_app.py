# function_app.py
import azure.functions as func
from app.main import app  # import your FastAPI app

asgi_app = func.AsgiFunctionApp(
    app=app,
    http_auth_level=func.AuthLevel.ANONYMOUS
)
