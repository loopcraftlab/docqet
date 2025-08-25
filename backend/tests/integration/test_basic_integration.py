"""
Basic integration tests for Story 1.1
"""

import sys
import os

sys.path.append(
    os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
)

from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


def test_basic_integration():
    """Test basic integration - all endpoints respond"""

    # Test root endpoint
    response = client.get("/")
    assert response.status_code == 200
    data = response.json()
    assert data["message"] == "Welcome to Docqet API"

    # Test health endpoint
    response = client.get("/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"

    # Test API v1 health endpoint
    response = client.get("/api/v1/health/")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"

    # Test placeholder endpoints
    response = client.get("/api/v1/auth/")
    assert response.status_code == 200

    response = client.get("/api/v1/documents/")
    assert response.status_code == 200

    response = client.get("/api/v1/ai/")
    assert response.status_code == 200


def test_story_1_1_completion():
    """Test that Story 1.1 requirements are met"""

    # Verify all placeholder endpoints return correct story information
    auth_response = client.get("/api/v1/auth/")
    auth_data = auth_response.json()
    assert auth_data["story"] == "1.2: User Authentication and Authorization"

    docs_response = client.get("/api/v1/documents/")
    docs_data = docs_response.json()
    assert docs_data["story"] == "1.3: Basic Document Upload and Storage"

    ai_response = client.get("/api/v1/ai/")
    ai_data = ai_response.json()
    assert ai_data["story"] == "1.4: Core AI Integration Setup"
