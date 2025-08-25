# Development Guide

This guide provides detailed instructions for setting up and contributing to the Docqet development environment.

## 🚀 Quick Start

### Prerequisites

- **Docker & Docker Compose**: [Install Docker](https://docs.docker.com/get-docker/)
- **Python 3.11+**: [Install Python](https://www.python.org/downloads/)
- **Node.js 18+**: [Install Node.js](https://nodejs.org/)
- **Git**: [Install Git](https://git-scm.com/)

### Environment Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/loopcraftlab/docqet.git
   cd docqet
   ```

2. **Start development environment**
   ```bash
   make dev
   ```

3. **Access the application**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8000
   - API Documentation: http://localhost:8000/docs

## 🏗️ Project Architecture

### Technology Stack

#### Backend
- **Framework**: FastAPI (Python 3.11+)
- **Database**: PostgreSQL 14+ with SQLAlchemy ORM
- **Cache**: Redis 7+
- **Authentication**: JWT with refresh tokens
- **Documentation**: OpenAPI/Swagger
- **Testing**: pytest with coverage

#### Frontend
- **Framework**: Next.js 14 with App Router
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **State Management**: React hooks + Context
- **Testing**: Jest + React Testing Library
- **Build Tool**: Vite

#### Infrastructure
- **Containerization**: Docker + Docker Compose
- **CI/CD**: GitHub Actions
- **Monitoring**: Built-in logging and health checks
- **Security**: SSL/TLS, rate limiting, input validation

### Directory Structure

```
docqet/
├── backend/                 # FastAPI backend
│   ├── app/
│   │   ├── api/            # API endpoints
│   │   │   └── v1/        # API version 1
│   │   ├── core/          # Core configuration
│   │   ├── models/        # Database models
│   │   ├── schemas/       # Pydantic schemas
│   │   └── services/      # Business logic
│   ├── alembic/           # Database migrations
│   ├── tests/             # Backend tests
│   └── requirements.txt   # Python dependencies
├── frontend/              # Next.js frontend
│   ├── app/              # Next.js app directory
│   ├── components/       # React components
│   ├── lib/             # Utility functions
│   ├── __tests__/       # Frontend tests
│   └── package.json     # Node.js dependencies
├── infrastructure/       # Infrastructure configs
├── docs/                # Documentation
├── .github/             # GitHub workflows and templates
└── docker-compose.yml   # Docker services
```

## 🔧 Development Workflow

### Backend Development

#### Setting Up Backend Environment

```bash
cd backend

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Install development dependencies
pip install pytest pytest-cov black flake8 mypy
```

#### Running Backend

```bash
# Start backend with auto-reload
uvicorn main:app --reload --host 0.0.0.0 --port 8000

# Or use the Makefile
make dev-backend
```

#### Database Management

```bash
# Run migrations
alembic upgrade head

# Create new migration
alembic revision --autogenerate -m "Description of changes"

# Reset database
alembic downgrade base
alembic upgrade head
```

#### Backend Testing

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=app --cov-report=html

# Run specific test file
pytest tests/test_auth.py

# Run with verbose output
pytest -v
```

### Frontend Development

#### Setting Up Frontend Environment

```bash
cd frontend

# Install dependencies
npm install

# Install development dependencies
npm install --save-dev @types/jest @testing-library/react
```

#### Running Frontend

```bash
# Start development server
npm run dev

# Or use the Makefile
make dev-frontend
```

#### Frontend Testing

```bash
# Run all tests
npm test

# Run with coverage
npm test -- --coverage

# Run tests in watch mode
npm test -- --watch

# Run specific test file
npm test -- --testPathPattern=HomePage.test.tsx
```

### Database Development

#### PostgreSQL Setup

```bash
# Start PostgreSQL container
docker compose up -d postgres

# Connect to database
docker compose exec postgres psql -U docqet -d docqet

# View tables
\dt

# Run queries
SELECT * FROM users LIMIT 5;
```

#### Redis Setup

```bash
# Start Redis container
docker compose up -d redis

# Connect to Redis CLI
docker compose exec redis redis-cli

# Test connection
ping
```

## 🧪 Testing Strategy

### Backend Testing

#### Unit Tests
- Test individual functions and classes
- Mock external dependencies
- Use pytest fixtures for test data
- Aim for 90%+ code coverage

```python
import pytest
from unittest.mock import Mock
from app.services.user_service import UserService

def test_create_user():
    # Arrange
    user_data = {"email": "test@example.com", "name": "Test User"}
    mock_db = Mock()
    service = UserService(mock_db)
    
    # Act
    result = service.create_user(user_data)
    
    # Assert
    assert result.email == user_data["email"]
    mock_db.add.assert_called_once()
```

#### Integration Tests
- Test API endpoints
- Use test database
- Test database operations
- Verify external service integrations

```python
import pytest
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_create_user_endpoint():
    response = client.post(
        "/api/v1/users/",
        json={"email": "test@example.com", "name": "Test User"}
    )
    assert response.status_code == 201
    assert response.json()["email"] == "test@example.com"
```

### Frontend Testing

#### Component Tests
- Test component rendering
- Test user interactions
- Mock API calls
- Test error states

```typescript
import { render, screen, fireEvent } from '@testing-library/react';
import { UserProfile } from './UserProfile';

test('displays user information', () => {
  const user = { id: 1, name: 'John Doe', email: 'john@example.com' };
  render(<UserProfile user={user} />);
  
  expect(screen.getByText('John Doe')).toBeInTheDocument();
  expect(screen.getByText('john@example.com')).toBeInTheDocument();
});

test('handles edit button click', () => {
  const mockOnEdit = jest.fn();
  const user = { id: 1, name: 'John Doe', email: 'john@example.com' };
  
  render(<UserProfile user={user} onEdit={mockOnEdit} />);
  
  fireEvent.click(screen.getByText('Edit'));
  expect(mockOnEdit).toHaveBeenCalledWith(user.id);
});
```

#### API Integration Tests
- Test API calls
- Mock responses
- Test error handling
- Verify data flow

## 🔍 Code Quality

### Backend Code Standards

#### Python Style Guide
- Follow PEP 8
- Use type hints
- Maximum line length: 88 characters (Black)
- Use docstrings for all public functions

```python
from typing import List, Optional

def process_documents(
    documents: List[dict], 
    user_id: Optional[int] = None
) -> List[dict]:
    """
    Process a list of documents and return analysis results.
    
    Args:
        documents: List of document dictionaries
        user_id: Optional user ID for access control
        
    Returns:
        List of processed document results
    """
    # Implementation
    pass
```

#### Code Formatting
```bash
# Format code with Black
black .

# Sort imports with isort
isort .

# Check code style with flake8
flake8 .

# Type checking with mypy
mypy .
```

### Frontend Code Standards

#### TypeScript Standards
- Use strict TypeScript configuration
- Define interfaces for all data structures
- Use functional components with hooks
- Implement proper error handling

```typescript
interface User {
  id: number;
  email: string;
  name: string;
  createdAt: string;
}

interface UserProfileProps {
  user: User;
  onEdit?: (userId: number) => void;
  onDelete?: (userId: number) => void;
}

const UserProfile: React.FC<UserProfileProps> = ({ 
  user, 
  onEdit, 
  onDelete 
}) => {
  const [isLoading, setIsLoading] = useState(false);
  
  const handleEdit = useCallback(() => {
    onEdit?.(user.id);
  }, [user.id, onEdit]);
  
  // Component implementation
};
```

#### Code Formatting
```bash
# Format code with Prettier
npm run format

# Lint code with ESLint
npm run lint

# Type checking
npm run type-check
```

## 🐳 Docker Development

### Container Management

```bash
# Start all services
docker compose up -d

# View logs
docker compose logs -f

# Stop services
docker compose down

# Rebuild containers
docker compose build --no-cache

# Execute commands in containers
docker compose exec backend python manage.py shell
docker compose exec frontend npm run build
```

### Development vs Production

#### Development
- Uses Docker Compose for local development
- Hot reloading enabled
- Debug mode enabled
- Local database and cache

#### Production
- Uses production Docker images
- Optimized builds
- Environment-specific configurations
- Production database and cache

## 🔐 Security Development

### Authentication & Authorization

#### JWT Implementation
```python
from datetime import datetime, timedelta
from jose import JWTError, jwt
from passlib.context import CryptContext

# Password hashing
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password: str) -> str:
    return pwd_context.hash(password)

# JWT token creation
def create_access_token(data: dict, expires_delta: timedelta = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt
```

#### API Security
- Input validation with Pydantic
- Rate limiting
- CORS configuration
- Security headers

### Data Protection

#### Database Security
- Parameterized queries
- Input sanitization
- Access control
- Audit logging

#### File Upload Security
- File type validation
- Size limits
- Virus scanning
- Secure storage

## 📊 Performance Development

### Backend Performance

#### Database Optimization
```python
# Use database indexes
class User(Base):
    __tablename__ = "users"
    
    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True)
    created_at = Column(DateTime, index=True)

# Optimize queries
def get_users_with_documents():
    return db.query(User).options(
        joinedload(User.documents)
    ).all()
```

#### Caching Strategy
```python
from fastapi_cache import FastAPICache
from fastapi_cache.backends.redis import RedisBackend

# Cache expensive operations
@cache(expire=3600)
async def get_document_analysis(document_id: int):
    # Expensive analysis operation
    pass
```

### Frontend Performance

#### Code Splitting
```typescript
// Lazy load components
const UserProfile = lazy(() => import('./UserProfile'));

// Route-based code splitting
const routes = [
  {
    path: '/users/:id',
    component: lazy(() => import('./pages/UserDetail'))
  }
];
```

#### State Management
```typescript
// Use React Query for server state
const { data: users, isLoading } = useQuery({
  queryKey: ['users'],
  queryFn: fetchUsers,
  staleTime: 5 * 60 * 1000, // 5 minutes
});
```

## 🚀 Deployment Development

### Environment Configuration

#### Environment Variables
```bash
# Backend (.env)
DATABASE_URL=postgresql://user:password@localhost:5432/docqet
REDIS_URL=redis://localhost:6379
SECRET_KEY=your-secret-key
JWT_SECRET_KEY=your-jwt-secret
OPENAI_API_KEY=your-openai-key

# Frontend (.env.local)
NEXT_PUBLIC_API_URL=http://localhost:8000
NEXT_PUBLIC_APP_URL=http://localhost:3000
```

#### Docker Environment
```yaml
# docker-compose.yml
services:
  backend:
    environment:
      - DATABASE_URL=postgresql://docqet:docqet_password@postgres:5432/docqet
      - REDIS_URL=redis://redis:6379
      - SECRET_KEY=${SECRET_KEY}
```

### Build Process

#### Backend Build
```dockerfile
# Dockerfile.dev
FROM python:3.11-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
CMD ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]
```

#### Frontend Build
```dockerfile
# Dockerfile.dev
FROM node:18-alpine

WORKDIR /app
COPY package*.json ./
RUN npm ci

COPY . .
CMD ["npm", "run", "dev"]
```

## 🐛 Debugging

### Backend Debugging

#### Logging
```python
import logging

logger = logging.getLogger(__name__)

def process_document(document_id: int):
    logger.info(f"Processing document {document_id}")
    try:
        # Processing logic
        logger.info(f"Document {document_id} processed successfully")
    except Exception as e:
        logger.error(f"Error processing document {document_id}: {e}")
        raise
```

#### Debug Mode
```python
# Enable debug mode
if DEBUG:
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000, reload=True)
```

### Frontend Debugging

#### React DevTools
- Install React Developer Tools browser extension
- Use React DevTools Profiler for performance analysis
- Debug component state and props

#### Console Debugging
```typescript
// Add debug logging
const handleSubmit = (data: FormData) => {
  console.log('Form data:', data);
  // Submit logic
};

// Use React Query DevTools
import { ReactQueryDevtools } from '@tanstack/react-query-devtools';

function App() {
  return (
    <>
      {/* Your app */}
      <ReactQueryDevtools initialIsOpen={false} />
    </>
  );
}
```

## 📚 Additional Resources

### Documentation
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Next.js Documentation](https://nextjs.org/docs)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Docker Documentation](https://docs.docker.com/)

### Tools
- [Postman](https://www.postman.com/) - API testing
- [pgAdmin](https://www.pgadmin.org/) - Database management
- [Redis Commander](https://github.com/joeferner/redis-commander) - Redis management
- [VS Code Extensions](https://marketplace.visualstudio.com/) - Development tools

### Community
- [GitHub Discussions](https://github.com/loopcraftlab/docqet/discussions)
- [GitHub Issues](https://github.com/loopcraftlab/docqet/issues)
- [Contributing Guide](CONTRIBUTING.md)

---

This guide should be updated as the project evolves. For questions or suggestions, please create an issue or discussion on GitHub. 