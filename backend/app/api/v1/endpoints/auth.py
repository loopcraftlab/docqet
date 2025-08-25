"""
Authentication endpoints
Story 1.2: User Authentication and Authorization
"""

from fastapi import APIRouter

router = APIRouter()


@router.get("/")
async def auth_info():
    """Authentication info endpoint - to be implemented in Story 1.2"""
    return {
        "message": "Authentication endpoints will be implemented in Story 1.2",
        "story": "1.2: User Authentication and Authorization",
        "status": "pending",
    }
