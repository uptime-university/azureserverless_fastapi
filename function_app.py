import azure.functions as func
from app.main import app

# Correct ASGI app setup (no extra route prefix)
asgi_app = func.AsgiFunctionApp(
    app=app,
    http_auth_level=func.AuthLevel.ANONYMOUS
)

