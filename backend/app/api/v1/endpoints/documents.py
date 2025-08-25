"""
Document management endpoints
Story 1.3: Basic Document Upload and Storage
"""

from fastapi import APIRouter

router = APIRouter()


@router.get("/")
async def documents_info():
    """Documents info endpoint - to be implemented in Story 1.3"""
    return {
        "message": "Document management endpoints will be implemented in Story 1.3",
        "story": "1.3: Basic Document Upload and Storage",
        "status": "pending"
    } 