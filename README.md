# Docqet - AI-Powered Document Management Platform

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![Node.js](https://img.shields.io/badge/node.js-18+-green.svg)](https://nodejs.org/)
[![Docker](https://img.shields.io/badge/docker-required-blue.svg)](https://www.docker.com/)

Docqet is an open-source, AI-powered document management platform that enables intelligent document processing, analysis, and collaboration. Built with modern technologies and designed for scalability, Docqet provides a comprehensive solution for document workflows.

## 🚀 Features

- **AI-Powered Document Analysis**: Intelligent document processing and content extraction
- **Real-time Collaboration**: Multi-user document editing and sharing
- **Advanced Search**: Semantic search capabilities across document content
- **Document Versioning**: Complete version history and change tracking
- **Secure Storage**: Enterprise-grade security and access controls
- **API-First Design**: RESTful APIs for seamless integration
- **Modern UI**: Responsive, accessible web interface

## 🏗️ Architecture

Docqet follows a modern microservices architecture:

- **Frontend**: Next.js with TypeScript and Tailwind CSS
- **Backend**: FastAPI with Python 3.8+
- **Database**: PostgreSQL with SQLAlchemy ORM
- **Cache**: Redis for session management and caching
- **Search**: Vector-based semantic search
- **Containerization**: Docker and Docker Compose

## 📋 Prerequisites

- Docker and Docker Compose
- Python 3.8 or higher
- Node.js 18 or higher
- Git

## 🛠️ Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/loopcraftlab/docqet.git
cd docqet
```

### 2. Start Development Environment

```bash
make dev
```

This command will:
- Install all dependencies
- Set up the database
- Run database migrations
- Start all services

### 3. Access the Application

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8000
- **API Documentation**: http://localhost:8000/docs

## 🐳 Docker Setup

### Using Docker Compose

```bash
# Start all services
docker compose up -d

# View logs
docker compose logs -f

# Stop services
docker compose down
```

### Individual Services

```bash
# Start only database services
docker compose up -d postgres redis

# Start backend
docker compose up -d backend

# Start frontend
docker compose up -d frontend
```

## 🔧 Development

### Backend Development

```bash
cd backend

# Install dependencies
pip install -r requirements.txt

# Run migrations
alembic upgrade head

# Start development server
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

### Frontend Development

```bash
cd frontend

# Install dependencies
npm install

# Start development server
npm run dev
```

### Database Management

```bash
# Run migrations
make migrate

# Create new migration
cd backend && alembic revision --autogenerate -m "Description"

# Reset database
make reset-db
```

## 🧪 Testing

```bash
# Run backend tests
cd backend && python -m pytest

# Run frontend tests
cd frontend && npm test

# Run integration tests
make test-integration
```

## 📚 API Documentation

The API documentation is automatically generated and available at:
- **Swagger UI**: http://localhost:8000/docs
- **ReDoc**: http://localhost:8000/redoc

## 🤝 Contributing

We welcome contributions from the community! Please read our [Contributing Guidelines](CONTRIBUTING.md) before submitting pull requests.

### Development Workflow

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Make your changes and add tests
4. Commit your changes: `git commit -m 'Add some feature'`
5. Push to the branch: `git push origin feature/your-feature-name`
6. Submit a pull request

### Code Style

- **Python**: Follow PEP 8 guidelines
- **TypeScript**: Use ESLint and Prettier configurations
- **Commits**: Use conventional commit messages

## 📋 Project Structure

```
docqet/
├── backend/                 # FastAPI backend
│   ├── app/
│   │   ├── api/            # API endpoints
│   │   ├── core/           # Core configuration
│   │   └── models/         # Database models
│   ├── alembic/            # Database migrations
│   └── tests/              # Backend tests
├── frontend/               # Next.js frontend
│   ├── app/                # Next.js app directory
│   ├── components/         # React components
│   └── __tests__/          # Frontend tests
├── infrastructure/         # Infrastructure configuration
├── docs/                   # Documentation
└── docker-compose.yml      # Docker services
```

## 🚀 Deployment

### Production Deployment

```bash
# Build production images
docker compose -f docker-compose.prod.yml build

# Deploy to production
docker compose -f docker-compose.prod.yml up -d
```

### Environment Variables

Create a `.env` file in the root directory:

```env
# Database
DATABASE_URL=postgresql://user:password@localhost:5432/docqet

# Redis
REDIS_URL=redis://localhost:6379

# Security
SECRET_KEY=your-secret-key
JWT_SECRET_KEY=your-jwt-secret

# External Services
OPENAI_API_KEY=your-openai-key
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- **Documentation**: [docs/](docs/)
- **Issues**: [GitHub Issues](https://github.com/loopcraftlab/docqet/issues)
- **Discussions**: [GitHub Discussions](https://github.com/loopcraftlab/docqet/discussions)

## 🙏 Acknowledgments

- Built with [FastAPI](https://fastapi.tiangolo.com/)
- Frontend powered by [Next.js](https://nextjs.org/)
- Styled with [Tailwind CSS](https://tailwindcss.com/)
- Database migrations with [Alembic](https://alembic.sqlalchemy.org/)

## 📊 Project Status

- **Current Version**: 0.1.0
- **Development Status**: Active Development
- **Contributors**: [Contributors](https://github.com/loopcraftlab/docqet/graphs/contributors)

---

Made with ❤️ by the [LoopCraft Lab](https://github.com/loopcraftlab) team 