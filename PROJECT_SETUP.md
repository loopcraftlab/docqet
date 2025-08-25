# Docqet Project Setup Guide

## 🚀 Quick Start

### Prerequisites

- **Node.js** 18+ 
- **Python** 3.11+
- **Docker** (optional, for local databases)
- **GitHub CLI** (optional, for GitHub features)

### Automated Setup

Run the automated setup script:

```bash
./scripts/setup-project.sh
```

This script will:
- ✅ Check system requirements
- ✅ Configure GitHub repository
- ✅ Set up GitHub labels
- ✅ Install all dependencies
- ✅ Configure development environment
- ✅ Set up databases
- ✅ Run initial tests

### Manual Setup

If you prefer manual setup, follow these steps:

#### 1. Install Dependencies

```bash
# Frontend dependencies
cd frontend
npm install
cd ..

# Backend dependencies
cd backend
python3 -m pip install -r requirements.txt
cd ..

# Pre-commit hooks
python3 -m pip install pre-commit
pre-commit install
```

#### 2. Environment Configuration

Create environment files:

**Backend** (`backend/.env`):
```env
ENVIRONMENT=development
DEBUG=true
DATABASE_URL=postgresql://docqet:docqet_password@localhost:5432/docqet
REDIS_URL=redis://localhost:6379
SECRET_KEY=dev-secret-key-change-in-production
```

**Frontend** (`frontend/.env.local`):
```env
NEXT_PUBLIC_API_URL=http://localhost:8000
NEXT_PUBLIC_APP_NAME=Docqet
```

#### 3. Database Setup

```bash
# Start databases
docker compose up -d postgres redis

# Run migrations
cd backend
python3 -m alembic upgrade head
cd ..
```

#### 4. Start Development

```bash
# Start all services
make dev

# Or start individually
make dev-frontend  # Frontend only
make dev-backend   # Backend only
make dev-db        # Databases only
```

## 🏗️ Project Structure

```
docqet/
├── backend/                 # FastAPI backend
│   ├── app/                # Application code
│   │   ├── api/           # API endpoints
│   │   ├── core/          # Core configuration
│   │   └── models/        # Data models
│   ├── tests/             # Backend tests
│   └── requirements.txt   # Python dependencies
├── frontend/              # Next.js frontend
│   ├── app/              # Next.js app directory
│   ├── components/       # React components
│   └── package.json      # Node.js dependencies
├── infrastructure/       # Infrastructure configs
├── scripts/             # Setup and utility scripts
├── docs/               # Documentation
└── docker-compose.yml  # Development environment
```

## 🧪 Testing

### Run All Tests
```bash
make test
```

### Individual Test Suites
```bash
# Backend tests
make test-backend

# Frontend tests
make test-frontend

# Integration tests
make test-integration
```

### CI Checks
```bash
# Run all CI checks locally
make ci

# Individual checks
make lint-backend
make lint-frontend
```

## 🔧 Development Commands

### Makefile Commands
```bash
make help              # Show all available commands
make dev               # Start development environment
make install           # Install all dependencies
make setup-db          # Setup databases
make migrate           # Run database migrations
make logs              # Show service logs
make stop              # Stop all services
make clean             # Clean up containers
```

### Manual Commands
```bash
# Backend
cd backend
python3 -m uvicorn main:app --reload --host 0.0.0.0 --port 8000

# Frontend
cd frontend
npm run dev

# Database
docker compose up -d postgres redis
```

## 🌐 Access Points

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8000
- **API Documentation**: http://localhost:8000/docs
- **PostgreSQL**: localhost:5432
- **Redis**: localhost:6379

## 📋 GitHub Setup

### Repository Configuration

The project is configured with:
- ✅ Repository description and topics
- ✅ Issues, Wiki, and Projects enabled
- ✅ Custom labels for project management
- ✅ Branch protection rules
- ✅ Automated CI/CD pipeline

### GitHub CLI Commands

```bash
# View repository
gh repo view --web

# Create issue
gh issue create --title "Title" --body "Description" --label "label1,label2"

# Create pull request
gh pr create --title "Title" --body "Description"

# View workflow runs
gh run list
```

## 🏷️ Project Labels

The repository uses the following label categories:

### Type Labels
- `bug` - Something isn't working
- `enhancement` - New feature or request
- `documentation` - Documentation improvements
- `question` - Further information needed

### Component Labels
- `frontend` - Frontend related changes
- `backend` - Backend related changes
- `ai` - AI/ML related features
- `database` - Database related changes
- `security` - Security related changes

### Priority Labels
- `priority-high` - High priority issue
- `priority-medium` - Medium priority issue
- `priority-low` - Low priority issue

### Story Labels
- `story-1.1` - Project Setup and Development Environment
- `story-1.2` - User Authentication and Authorization
- `story-1.3` - Basic Document Upload and Storage
- `story-1.4` - Core AI Integration Setup

## 🔄 CI/CD Pipeline

### GitHub Actions Workflows

1. **CI/CD Pipeline** (`.github/workflows/ci.yml`)
   - Runs on push to main/develop and PRs
   - Tests backend, frontend, and integration
   - Security scanning with Trivy
   - Docker image building and deployment

2. **Project Setup** (`.github/workflows/setup-project.yml`)
   - Automated repository configuration
   - Label management
   - Issue creation
   - Project board setup

### Local CI Checks

```bash
# Run all CI checks
make ci

# Individual checks
make lint-backend    # Black, flake8, mypy
make lint-frontend   # ESLint, TypeScript
make test-backend    # pytest with coverage
make test-frontend   # Jest with coverage
```

## 🐛 Troubleshooting

### Common Issues

#### Database Connection Issues
```bash
# Check if databases are running
docker compose ps

# Restart databases
docker compose restart postgres redis

# Check database logs
docker compose logs postgres
```

#### Port Conflicts
```bash
# Check what's using a port
lsof -i :8000
lsof -i :3000

# Kill process using port
kill -9 <PID>
```

#### Dependency Issues
```bash
# Clear npm cache
npm cache clean --force

# Clear pip cache
pip cache purge

# Reinstall dependencies
make install
```

#### Test Failures
```bash
# Run tests with verbose output
cd backend && pytest -v
cd frontend && npm test -- --verbose
```

### Getting Help

1. Check the [GitHub Issues](https://github.com/loopcraftlab/docqet/issues)
2. Review the [Documentation](docs/)
3. Run `make help` for available commands
4. Check service logs with `make logs`

## 📚 Additional Resources

- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Next.js Documentation](https://nextjs.org/docs)
- [Docker Documentation](https://docs.docker.com/)
- [GitHub CLI Documentation](https://cli.github.com/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests: `make ci`
5. Submit a pull request

For more details, see [CONTRIBUTING.md](CONTRIBUTING.md).

---

**Happy coding! 🚀** 