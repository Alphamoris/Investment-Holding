from fastapi import APIRouter
from app.routers import holdings

router = APIRouter()

router.include_router(holdings.router)
