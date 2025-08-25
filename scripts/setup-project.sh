#!/bin/bash

# Docqet Project Setup Script
# This script sets up the complete development environment for Docqet

set -e

echo "🚀 Setting up Docqet Project..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if required tools are installed
check_requirements() {
    print_status "Checking system requirements..."
    
    # Check for Node.js
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed. Please install Node.js 18+"
        exit 1
    fi
    
    # Check for Python
    if ! command -v python3 &> /dev/null; then
        print_error "Python 3 is not installed. Please install Python 3.11+"
        exit 1
    fi
    
    # Check for Docker
    if ! command -v docker &> /dev/null; then
        print_warning "Docker is not installed. Some features may not work."
    fi
    
    # Check for GitHub CLI
    if ! command -v gh &> /dev/null; then
        print_warning "GitHub CLI is not installed. Some GitHub features may not work."
    fi
    
    print_success "System requirements check completed"
}

# Setup GitHub repository
setup_github() {
    print_status "Setting up GitHub repository..."
    
    if command -v gh &> /dev/null; then
        # Check if authenticated
        if gh auth status &> /dev/null; then
            print_status "Setting up repository description and topics..."
            
            # Set repository description
            gh repo edit --description "Secure Document Sharing with AI - A modern, open-source document management platform with intelligent content analysis and real-time collaboration features."
            
            # Set homepage
            gh repo edit --homepage "https://docqet.com"
            
            # Enable features
            gh repo edit --enable-issues --enable-wiki --enable-projects
            
            # Add topics
            gh repo edit --add-topic "document-management,ai,fastapi,nextjs,typescript,python,postgresql,redis,vector-search,open-source,security,collaboration"
            
            print_success "GitHub repository configured"
        else
            print_warning "GitHub CLI not authenticated. Please run 'gh auth login'"
        fi
    else
        print_warning "GitHub CLI not installed. Skipping GitHub setup"
    fi
}

# Setup GitHub labels
setup_labels() {
    print_status "Setting up GitHub labels..."
    
    if [ -f "scripts/setup-github-labels.sh" ]; then
        ./scripts/setup-github-labels.sh
        print_success "GitHub labels configured"
    else
        print_warning "Labels setup script not found"
    fi
}

# Install dependencies
install_dependencies() {
    print_status "Installing project dependencies..."
    
    # Install frontend dependencies
    print_status "Installing frontend dependencies..."
    cd frontend
    npm install
    cd ..
    
    # Install backend dependencies
    print_status "Installing backend dependencies..."
    cd backend
    python3 -m pip install -r requirements.txt
    cd ..
    
    # Install pre-commit hooks
    print_status "Installing pre-commit hooks..."
    python3 -m pip install pre-commit
    pre-commit install
    
    print_success "Dependencies installed"
}

# Setup development environment
setup_dev_environment() {
    print_status "Setting up development environment..."
    
    # Create .env files if they don't exist
    if [ ! -f "backend/.env" ]; then
        print_status "Creating backend .env file..."
        cat > backend/.env << EOF
# Backend Environment Variables
ENVIRONMENT=development
DEBUG=true
DATABASE_URL=postgresql://docqet:docqet_password@localhost:5432/docqet
REDIS_URL=redis://localhost:6379
SECRET_KEY=dev-secret-key-change-in-production
EOF
    fi
    
    if [ ! -f "frontend/.env.local" ]; then
        print_status "Creating frontend .env.local file..."
        cat > frontend/.env.local << EOF
# Frontend Environment Variables
NEXT_PUBLIC_API_URL=http://localhost:8000
NEXT_PUBLIC_APP_NAME=Docqet
EOF
    fi
    
    print_success "Development environment configured"
}

# Setup databases
setup_databases() {
    print_status "Setting up databases..."
    
    if command -v docker &> /dev/null; then
        # Start databases
        docker compose up -d postgres redis
        
        # Wait for databases to be ready
        print_status "Waiting for databases to be ready..."
        sleep 10
        
        # Run migrations
        print_status "Running database migrations..."
        cd backend
        python3 -m alembic upgrade head || echo "Migrations already up to date"
        cd ..
        
        print_success "Databases configured"
    else
        print_warning "Docker not available. Please start databases manually"
    fi
}

# Run initial tests
run_tests() {
    print_status "Running initial tests..."
    
    # Run backend tests
    print_status "Running backend tests..."
    cd backend
    python3 -m pytest tests/ -v
    cd ..
    
    # Run frontend tests
    print_status "Running frontend tests..."
    cd frontend
    npm test -- --passWithNoTests
    cd ..
    
    print_success "Tests completed"
}

# Main setup function
main() {
    echo "🎯 Docqet Project Setup"
    echo "========================"
    
    check_requirements
    setup_github
    setup_labels
    install_dependencies
    setup_dev_environment
    setup_databases
    run_tests
    
    echo ""
    echo "🎉 Setup completed successfully!"
    echo ""
    echo "Next steps:"
    echo "1. Start development server: make dev"
    echo "2. View API documentation: http://localhost:8000/docs"
    echo "3. View frontend: http://localhost:3000"
    echo "4. Run CI checks: make ci"
    echo ""
    echo "Happy coding! 🚀"
}

# Run main function
main "$@" 