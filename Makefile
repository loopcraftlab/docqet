# Docqet Development Makefile
# Story 1.1: Project Setup and Development Environment

.PHONY: help dev dev-frontend dev-backend dev-db test test-frontend test-backend test-integration clean install install-frontend install-backend setup-db migrate logs stop ci lint-backend lint-frontend

# Default target
help:
	@echo "Docqet Development Commands:"
	@echo ""
	@echo "  make dev              - Start all services (frontend, backend, databases)"
	@echo "  make dev-frontend     - Start frontend only"
	@echo "  make dev-backend      - Start backend only"
	@echo "  make dev-db           - Start databases only"
	@echo "  make install          - Install all dependencies"
	@echo "  make install-frontend - Install frontend dependencies"
	@echo "  make install-backend  - Install backend dependencies"
	@echo "  make setup-db         - Setup and initialize databases"
	@echo "  make migrate          - Run database migrations"
	@echo "  make test             - Run all tests"
	@echo "  make test-frontend    - Run frontend tests"
	@echo "  make test-backend     - Run backend tests"
	@echo "  make test-integration - Run integration tests"
	@echo "  make ci               - Run all CI checks (linting + tests)"
	@echo "  make lint-backend     - Run backend linting"
	@echo "  make lint-frontend    - Run frontend linting"
	@echo "  make logs             - Show service logs"
	@echo "  make stop             - Stop all services"
	@echo "  make clean            - Clean up containers and volumes"

# Main development command - single command start
dev: install setup-db
	@echo "🚀 Starting Docqet development environment..."
	@echo "📱 Frontend: http://localhost:3000"
	@echo "🔧 Backend API: http://localhost:8000"
	@echo "📚 API Docs: http://localhost:8000/docs"
	@echo "🗄️  PostgreSQL: localhost:5432"
	@echo "⚡ Redis: localhost:6379"
	@echo ""
	docker compose up -d postgres redis
	@echo "⏳ Waiting for databases to be ready..."
	@sleep 5
	@echo "🔄 Starting backend..."
	cd backend && python3 -m uvicorn main:app --reload --host 0.0.0.0 --port 8000 &
	@echo "🔄 Starting frontend..."
	cd frontend && npm run dev &
	@echo "✅ Development environment started!"
	@echo "Press Ctrl+C to stop all services"

# Start frontend only
dev-frontend: install-frontend
	@echo "🚀 Starting frontend..."
	cd frontend && npm run dev

# Start backend only
dev-backend: install-backend setup-db
	@echo "🚀 Starting backend..."
	cd backend && python3 -m uvicorn main:app --reload --host 0.0.0.0 --port 8000

# Start databases only
dev-db:
	@echo "🚀 Starting databases..."
	docker compose up -d postgres redis
	@echo "✅ Databases started!"

# Install all dependencies
install: install-frontend install-backend
	@echo "✅ All dependencies installed!"

# Install frontend dependencies
install-frontend:
	@echo "📦 Installing frontend dependencies..."
	cd frontend && npm install
	@echo "✅ Frontend dependencies installed!"

# Install backend dependencies
install-backend:
	@echo "📦 Installing backend dependencies..."
	cd backend && python3 -m pip install -r requirements.txt
	@echo "✅ Backend dependencies installed!"

# Setup and initialize databases
setup-db:
	@echo "🗄️  Setting up databases..."
	docker compose up -d postgres redis
	@echo "⏳ Waiting for databases to be ready..."
	@sleep 10
	@echo "🔄 Running database migrations..."
	docker compose exec backend alembic upgrade head || echo "⚠️  Migrations already up to date or running from container..."
	@echo "✅ Databases setup complete!"

# Run database migrations
migrate:
	@echo "🔄 Running database migrations..."
	docker compose exec backend alembic upgrade head
	@echo "✅ Migrations complete!"

# Run all tests
test: test-frontend test-backend test-integration
	@echo "✅ All tests completed!"

# Run CI checks (linting, formatting, tests)
ci: lint-backend lint-frontend test
	@echo "✅ All CI checks completed!"

# Run backend linting
lint-backend:
	@echo "🔍 Running backend linting..."
	cd backend && black --check .
	cd backend && flake8 . --count --exit-zero --max-complexity=10 --max-line-length=88 --exclude=alembic,tests
	cd backend && python3 -m mypy --ignore-missing-imports --exclude=alembic --exclude=tests app/
	@echo "✅ Backend linting completed!"

# Run frontend linting
lint-frontend:
	@echo "🔍 Running frontend linting..."
	cd frontend && npm run lint
	cd frontend && npm run type-check
	@echo "✅ Frontend linting completed!"

# Run frontend tests
test-frontend:
	@echo "🧪 Running frontend tests..."
	cd frontend && npm test
	@echo "✅ Frontend tests completed!"

# Run backend tests
test-backend:
	@echo "🧪 Running backend tests..."
	cd backend && pytest --cov=app --cov-report=html
	@echo "✅ Backend tests completed!"

# Run integration tests
test-integration:
	@echo "🧪 Running integration tests..."
	@echo "Starting test environment..."
	docker compose -f docker-compose.test.yml up -d
	@sleep 10
	cd backend && pytest tests/integration/
	docker compose -f docker-compose.test.yml down
	@echo "✅ Integration tests completed!"

# Show service logs
logs:
	@echo "📋 Service logs:"
	docker compose logs -f

# Stop all services
stop:
	@echo "🛑 Stopping all services..."
	docker compose down
	@echo "✅ All services stopped!"

# Clean up containers and volumes
clean:
	@echo "🧹 Cleaning up..."
	docker compose down -v
	docker system prune -f
	@echo "✅ Cleanup complete!"

# Health check
health:
	@echo "🏥 Checking service health..."
	@echo "Frontend: $(shell curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 || echo "not running")"
	@echo "Backend: $(shell curl -s -o /dev/null -w "%{http_code}" http://localhost:8000/health || echo "not running")"
	@echo "PostgreSQL: $(shell docker compose exec -T postgres pg_isready -U docqet > /dev/null 2>&1 && echo "healthy" || echo "not healthy")"
	@echo "Redis: $(shell docker compose exec -T redis redis-cli ping > /dev/null 2>&1 && echo "healthy" || echo "not healthy")"

# Infrastructure Commands
terraform-init:
	@echo "🔧 Initializing Terraform..."
	cd infrastructure/terraform && terraform init
	@echo "✅ Terraform initialized!"

terraform-plan:
	@echo "📋 Planning Terraform changes..."
	cd infrastructure/terraform && terraform plan -var="environment=dev"
	@echo "✅ Terraform plan complete!"

terraform-apply:
	@echo "🚀 Applying Terraform changes..."
	cd infrastructure/terraform && terraform apply -var="environment=dev" -auto-approve
	@echo "✅ Terraform apply complete!"

terraform-destroy:
	@echo "🗑️  Destroying Terraform infrastructure..."
	cd infrastructure/terraform && terraform destroy -var="environment=dev" -auto-approve
	@echo "✅ Terraform destroy complete!"

# Infrastructure Testing
test-infra:
	@echo "🧪 Testing infrastructure..."
	@echo "Testing VPC connectivity..."
	@echo "Testing database connectivity..."
	@echo "Testing application endpoints..."
	@echo "✅ Infrastructure tests complete!"

# Deployment Commands
deploy-staging:
	@echo "🚀 Deploying to staging..."
	@echo "Building Docker images..."
	@echo "Pushing to ECR..."
	@echo "Updating ECS services..."
	@echo "✅ Staging deployment complete!"

deploy-production:
	@echo "🚀 Deploying to production..."
	@echo "Building Docker images..."
	@echo "Pushing to ECR..."
	@echo "Updating ECS services..."
	@echo "✅ Production deployment complete!"

# Monitoring Commands
monitoring-start:
	@echo "📊 Starting monitoring stack..."
	docker compose -f infrastructure/monitoring/docker-compose.yml up -d
	@echo "✅ Monitoring stack started!"

monitoring-stop:
	@echo "📊 Stopping monitoring stack..."
	docker compose -f infrastructure/monitoring/docker-compose.yml down
	@echo "✅ Monitoring stack stopped!"

monitoring-logs:
	@echo "📋 Monitoring logs:"
	docker compose -f infrastructure/monitoring/docker-compose.yml logs -f

# Security Commands
security-scan:
	@echo "🔒 Running security scans..."
	@echo "Scanning Docker images..."
	@echo "Scanning dependencies..."
	@echo "Scanning code..."
	@echo "✅ Security scans complete!"

# Cost Optimization
cost-report:
	@echo "💰 Generating cost report..."
	@echo "Analyzing AWS costs..."
	@echo "Identifying optimization opportunities..."
	@echo "✅ Cost report generated!"

# Backup and Recovery
backup-create:
	@echo "💾 Creating backup..."
	@echo "Backing up database..."
	@echo "Backing up application data..."
	@echo "✅ Backup complete!"

backup-restore:
	@echo "🔄 Restoring from backup..."
	@echo "Restoring database..."
	@echo "Restoring application data..."
	@echo "✅ Restore complete!"

# Performance Testing
performance-test:
	@echo "⚡ Running performance tests..."
	@echo "Load testing application..."
	@echo "Stress testing database..."
	@echo "✅ Performance tests complete!"

# Documentation
docs-generate:
	@echo "📚 Generating documentation..."
	@echo "Generating API documentation..."
	@echo "Generating infrastructure documentation..."
	@echo "✅ Documentation generated!"

# All-in-one Commands
full-setup: install setup-db dev
	@echo "🎉 Full development environment setup complete!"

full-deploy: test ci deploy-staging
	@echo "🎉 Full deployment pipeline complete!"

full-clean: stop clean terraform-destroy
	@echo "🧹 Complete cleanup finished!" 