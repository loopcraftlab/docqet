"""
AI service endpoints
Story 1.4: Core AI Integration Setup
"""

from fastapi import APIRouter

router = APIRouter()


@router.get("/")
async def ai_info():
    """AI info endpoint - to be implemented in Story 1.4"""
    return {
        "message": "AI service endpoints will be implemented in Story 1.4",
        "story": "1.4: Core AI Integration Setup",
        "status": "pending"
    } 