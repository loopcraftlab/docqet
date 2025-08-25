"""
Tests for main FastAPI application
"""

import pytest
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


def test_root_endpoint():
    """Test root endpoint"""
    response = client.get("/")
    assert response.status_code == 200
    data = response.json()
    assert data["message"] == "Welcome to Docqet API"
    assert data["version"] == "0.1.0"
    assert data["status"] == "running"


def test_health_check():
    """Test health check endpoint"""
    response = client.get("/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"
    assert data["version"] == "0.1.0"


def test_ready_check():
    """Test readiness check endpoint"""
    response = client.get("/ready")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "ready"
    assert "services" in data


def test_api_v1_health():
    """Test API v1 health endpoint"""
    response = client.get("/api/v1/health/")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"
    assert data["service"] == "docqet-api"


def test_auth_endpoint():
    """Test auth endpoint placeholder"""
    response = client.get("/api/v1/auth/")
    assert response.status_code == 200
    data = response.json()
    assert data["story"] == "1.2: User Authentication and Authorization"
    assert data["status"] == "pending"


def test_documents_endpoint():
    """Test documents endpoint placeholder"""
    response = client.get("/api/v1/documents/")
    assert response.status_code == 200
    data = response.json()
    assert data["story"] == "1.3: Basic Document Upload and Storage"
    assert data["status"] == "pending"


def test_ai_endpoint():
    """Test AI endpoint placeholder"""
    response = client.get("/api/v1/ai/")
    assert response.status_code == 200
    data = response.json()
    assert data["story"] == "1.4: Core AI Integration Setup"
    assert data["status"] == "pending" 