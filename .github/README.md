# GitHub CI/CD Setup

This directory contains the GitHub Actions workflows and configuration for the Docqet project.

## Workflows

### 1. CI/CD Pipeline (`ci-cd.yml`)
The main CI/CD pipeline that runs on every push and pull request.

**Jobs:**
- **Quality Checks**: Linting, security scanning, and code quality checks
- **Testing**: Unit tests, integration tests, and coverage reporting
- **Security**: Vulnerability scanning with Trivy
- **Build & Deploy**: Docker image building and deployment to AWS
- **Staging Deployment**: Automatic deployment to staging environment
- **Production Deployment**: Automatic deployment to production environment

**Triggers:**
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop` branches

### 2. Project Setup (`setup-project.yml`)
Automated repository setup and maintenance.

**Tasks:**
- Repository configuration (description, topics, features)
- Branch protection setup
- Weekly maintenance tasks

**Triggers:**
- Manual dispatch
- Weekly schedule (Sundays at 2 AM UTC)

### 3. Release Automation (`release-automation.yml`)
Automated release creation and management.

**Tasks:**
- Version determination
- Changelog generation
- GitHub release creation
- Slack notifications

**Triggers:**
- Push of version tags (e.g., `v1.0.0`)
- Manual dispatch

## Required Secrets

Configure these secrets in your GitHub repository settings:

### AWS Credentials
- `AWS_ACCESS_KEY_ID`: AWS access key for deployment
- `AWS_SECRET_ACCESS_KEY`: AWS secret key for deployment

### Notifications
- `SLACK_WEBHOOK_URL`: Slack webhook URL for notifications

### Docker (Optional)
- `DOCKERHUB_USERNAME`: Docker Hub username
- `DOCKERHUB_TOKEN`: Docker Hub access token

## Environments

### Staging
- **Branch**: `develop`
- **Purpose**: Pre-production testing
- **Auto-deploy**: Yes

### Production
- **Branch**: `main`
- **Purpose**: Live application
- **Auto-deploy**: Yes (with approval)

## Branch Protection

The main branch is protected with:
- Required status checks: `quality-checks`, `test`, `security`
- Required pull request reviews (1 approval minimum)
- Dismiss stale reviews
- Enforce admins

## Templates

### Issue Templates
- **Bug Report**: For reporting bugs and issues
- **Feature Request**: For suggesting new features

### Pull Request Template
Standardized PR template with checklists and guidelines.

## Usage

### Development Workflow
1. Create a feature branch from `develop`
2. Make changes and commit
3. Push to GitHub
4. Create a pull request to `develop`
5. CI/CD pipeline runs automatically
6. After approval and merge, staging deployment triggers

### Release Workflow
1. Create and push a version tag: `git tag v1.0.0 && git push origin v1.0.0`
2. Release automation creates GitHub release
3. Production deployment triggers automatically

### Manual Actions
- **Project Setup**: Run manually or weekly for repository maintenance
- **Release Creation**: Run manually to create releases without tags

## Troubleshooting

### Common Issues
1. **Build Failures**: Check the logs for dependency or test failures
2. **Deployment Failures**: Verify AWS credentials and permissions
3. **Security Scan Failures**: Review and fix security vulnerabilities
4. **Test Failures**: Ensure all tests pass locally before pushing

### Debugging
- Check workflow logs in the Actions tab
- Verify secret configuration
- Test locally with `make test` and `make ci`

## Best Practices

1. **Always run tests locally** before pushing
2. **Use conventional commit messages** for better changelog generation
3. **Review security scan results** regularly
4. **Monitor deployment logs** for issues
5. **Keep dependencies updated** to avoid security vulnerabilities 