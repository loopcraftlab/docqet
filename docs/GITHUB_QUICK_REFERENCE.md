# GitHub Quick Reference Guide

This guide provides quick reference for common GitHub workflows and commands for the Docqet project.

## 🚀 Quick Start Commands

### Initial Setup
```bash
# Clone the repository
git clone https://github.com/loopcraftlab/docqet.git
cd docqet

# Start development environment
make dev
```

### Daily Development Workflow
```bash
# Get latest changes
git checkout main
git pull origin main

# Create feature branch
git checkout -b feature/your-feature-name

# Make changes and commit
git add .
git commit -m "feat: add your feature description"

# Push and create PR
git push origin feature/your-feature-name
# Then create PR on GitHub
```

## 📋 Common Git Commands

### Branch Management
```bash
# List all branches
git branch -a

# Create and switch to new branch
git checkout -b feature/new-feature

# Switch to existing branch
git checkout main

# Delete local branch
git branch -d feature/old-feature

# Delete remote branch
git push origin --delete feature/old-feature
```

### Commit Management
```bash
# Stage all changes
git add .

# Stage specific files
git add filename.py

# Commit with conventional message
git commit -m "feat: add new feature"
git commit -m "fix: resolve bug description"
git commit -m "docs: update documentation"
git commit -m "refactor: improve code structure"

# Amend last commit
git commit --amend -m "updated commit message"

# View commit history
git log --oneline -10
```

### Remote Management
```bash
# View remotes
git remote -v

# Add remote
git remote add origin https://github.com/loopcraftlab/docqet.git

# Fetch latest changes
git fetch origin

# Pull with rebase
git pull --rebase origin main
```

## 🔄 Pull Request Workflow

### Creating a PR
1. Push your feature branch
2. Go to GitHub repository
3. Click "Compare & pull request"
4. Fill out PR template
5. Request reviewers
6. Wait for CI/CD checks to pass

### PR Review Process
```bash
# Address review comments
git add .
git commit -m "fix: address review comments"
git push origin feature/your-feature-name

# Rebase on main if needed
git checkout main
git pull origin main
git checkout feature/your-feature-name
git rebase main
git push --force-with-lease origin feature/your-feature-name
```

## 🏷️ Issue Management

### Creating Issues
- Use appropriate template (Bug Report, Feature Request, Epic)
- Add relevant labels
- Assign to appropriate epic
- Set priority level

### Issue Labels Reference
- **Type**: `bug`, `enhancement`, `documentation`, `good first issue`
- **Priority**: `priority: high`, `priority: medium`, `priority: low`
- **Status**: `status: in progress`, `status: blocked`, `status: needs review`
- **Epic**: `epic: foundation`, `epic: document-management`, `epic: ai-analysis`

## 🚀 Release Process

### Creating a Release
```bash
# Create release branch
git checkout develop
git pull origin develop
git checkout -b release/v1.2.0

# Update version and changelog
# Edit version files and CHANGELOG.md
git add .
git commit -m "chore: prepare release v1.2.0"
git push origin release/v1.2.0

# Create PR to main
# After approval and merge:
git checkout main
git pull origin main
git tag v1.2.0
git push origin v1.2.0
```

### GitHub Release Creation
1. Go to GitHub repository
2. Click "Releases"
3. Click "Create a new release"
4. Choose the tag
5. Add release notes
6. Mark as latest release

## 🐳 Docker Commands

### Development
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

### Database Management
```bash
# Connect to PostgreSQL
docker compose exec postgres psql -U docqet -d docqet

# Connect to Redis
docker compose exec redis redis-cli

# Run migrations
docker compose exec backend alembic upgrade head
```

## 🧪 Testing Commands

### Backend Testing
```bash
# Run all tests
cd backend && pytest

# Run with coverage
pytest --cov=app --cov-report=html

# Run specific test
pytest tests/test_auth.py -v
```

### Frontend Testing
```bash
# Run all tests
cd frontend && npm test

# Run with coverage
npm test -- --coverage

# Run specific test
npm test -- --testPathPattern=HomePage.test.tsx
```

### Integration Testing
```bash
# Run integration tests
make test-integration
```

## 🔧 Development Commands

### Backend Development
```bash
# Install dependencies
cd backend
pip install -r requirements.txt

# Start development server
uvicorn main:app --reload --host 0.0.0.0 --port 8000

# Run linting
black .
flake8 .
mypy .
```

### Frontend Development
```bash
# Install dependencies
cd frontend
npm install

# Start development server
npm run dev

# Run linting
npm run lint

# Build for production
npm run build
```

## 📊 Project Management

### GitHub Projects
- Use kanban boards for task management
- Automate issue movement based on labels
- Track epic progress with milestones

### Milestones
- Create milestones for releases
- Assign issues to milestones
- Track progress with burndown charts

### Labels Management
```bash
# View all labels
# Go to Issues > Labels on GitHub

# Common label colors:
# - bug: #d73a4a (red)
# - enhancement: #a2eeef (light blue)
# - documentation: #0075ca (blue)
# - good first issue: #7057ff (purple)
```

## 🔍 Troubleshooting

### Common Issues

#### Merge Conflicts
```bash
# Resolve conflicts
git status  # See conflicted files
# Edit conflicted files
git add .
git commit -m "fix: resolve merge conflicts"
```

#### Stuck Rebase
```bash
# Abort rebase
git rebase --abort

# Continue rebase after resolving conflicts
git add .
git rebase --continue
```

#### Force Push (Use with caution)
```bash
# Force push after rebase
git push --force-with-lease origin feature/your-feature-name
```

#### Reset to Remote
```bash
# Reset local branch to match remote
git fetch origin
git reset --hard origin/main
```

## 📚 Useful Links

- [Repository](https://github.com/loopcraftlab/docqet)
- [Issues](https://github.com/loopcraftlab/docqet/issues)
- [Discussions](https://github.com/loopcraftlab/docqet/discussions)
- [Actions](https://github.com/loopcraftlab/docqet/actions)
- [Projects](https://github.com/loopcraftlab/docqet/projects)

## 🆘 Getting Help

- Check the [Development Guide](development.md)
- Review [Contributing Guidelines](CONTRIBUTING.md)
- Create an issue for bugs
- Start a discussion for questions
- Ask in team chat for urgent issues

---

This quick reference should be updated as workflows evolve. 