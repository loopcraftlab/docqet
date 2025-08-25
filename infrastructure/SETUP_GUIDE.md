# Docqet Infrastructure & DevOps Platform Setup Guide

## Overview

This guide will help you set up the complete infrastructure and DevOps platform for Docqet, enabling scalable, secure, and maintainable deployment across multiple environments.

## Prerequisites

### Required Tools
- **AWS CLI** (v2.0+) with appropriate permissions
- **Terraform** (v1.0+)
- **Docker** and **Docker Compose**
- **Make** (for automation)
- **Git** (for version control)

### AWS Account Setup
1. Create an AWS account with appropriate billing setup
2. Create an IAM user with the following permissions:
   - AdministratorAccess (for initial setup)
   - Or create custom policies for least privilege access

### Local Environment Setup
```bash
# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Configure AWS credentials
aws configure

# Install Terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs)"
sudo apt-get update && sudo apt-get install terraform

# Install Docker (if not already installed)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

## Quick Start

### 1. Clone and Setup Repository
```bash
git clone https://github.com/your-org/docqet.git
cd docqet

# Install dependencies
make install

# Start development environment
make dev
```

### 2. Infrastructure Setup

#### Development Environment
```bash
# Initialize Terraform
make terraform-init

# Plan infrastructure changes
make terraform-plan

# Apply infrastructure (optional for dev)
make terraform-apply
```

#### Staging Environment
```bash
# Deploy to staging
make deploy-staging
```

#### Production Environment
```bash
# Deploy to production
make deploy-production
```

## Detailed Setup Instructions

### 1. AWS Infrastructure Setup

#### S3 Backend for Terraform State
```bash
# Create S3 bucket for Terraform state
aws s3 mb s3://docqet-terraform-state

# Enable versioning
aws s3api put-bucket-versioning \
    --bucket docqet-terraform-state \
    --versioning-configuration Status=Enabled

# Create DynamoDB table for state locking
aws dynamodb create-table \
    --table-name docqet-terraform-locks \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
```

#### ECR Repositories
```bash
# Create ECR repositories
aws ecr create-repository --repository-name docqet-backend
aws ecr create-repository --repository-name docqet-frontend
```

### 2. Environment Configuration

#### Development Environment
Create `infrastructure/terraform/environments/dev.tfvars`:
```hcl
environment = "dev"
aws_region = "us-east-1"
vpc_cidr = "10.0.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

# Database
database_name = "docqet_dev"
database_username = "docqet_admin"
database_password = "your-secure-password"
database_instance_class = "db.t3.micro"

# Redis
redis_node_type = "cache.t3.micro"

# ECS
ecs_task_cpu = 256
ecs_task_memory = 512
ecs_service_desired_count = 1

# Auto Scaling
enable_auto_scaling = false
min_capacity = 1
max_capacity = 3

# Monitoring
enable_monitoring = false
enable_waf = false
enable_backup = false
```

#### Staging Environment
Create `infrastructure/terraform/environments/staging.tfvars`:
```hcl
environment = "staging"
aws_region = "us-east-1"
vpc_cidr = "10.1.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

# Database
database_name = "docqet_staging"
database_username = "docqet_admin"
database_password = "your-secure-password"
database_instance_class = "db.t3.small"

# Redis
redis_node_type = "cache.t3.small"

# ECS
ecs_task_cpu = 512
ecs_task_memory = 1024
ecs_service_desired_count = 2

# Auto Scaling
enable_auto_scaling = true
min_capacity = 1
max_capacity = 5

# Monitoring
enable_monitoring = true
enable_waf = false
enable_backup = true
```

#### Production Environment
Create `infrastructure/terraform/environments/production.tfvars`:
```hcl
environment = "production"
aws_region = "us-east-1"
vpc_cidr = "10.2.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

# Database
database_name = "docqet_prod"
database_username = "docqet_admin"
database_password = "your-secure-password"
database_instance_class = "db.t3.medium"

# Redis
redis_node_type = "cache.t3.medium"

# ECS
ecs_task_cpu = 1024
ecs_task_memory = 2048
ecs_service_desired_count = 3

# Auto Scaling
enable_auto_scaling = true
min_capacity = 2
max_capacity = 10

# Monitoring
enable_monitoring = true
enable_waf = true
enable_backup = true
```

### 3. Secrets Management

#### AWS Secrets Manager Setup
```bash
# Create secrets for each environment
aws secretsmanager create-secret \
    --name "docqet/dev/database" \
    --description "Database credentials for dev environment" \
    --secret-string '{"username":"docqet_admin","password":"your-secure-password"}'

aws secretsmanager create-secret \
    --name "docqet/dev/jwt" \
    --description "JWT secret for dev environment" \
    --secret-string '{"secret":"your-jwt-secret"}'
```

### 4. Monitoring Setup

#### Prometheus and Grafana
```bash
# Start monitoring stack
make monitoring-start

# Access Grafana
# URL: http://localhost:3000
# Default credentials: admin/admin
```

#### CloudWatch Alarms
```bash
# Create CloudWatch alarms for monitoring
aws cloudwatch put-metric-alarm \
    --alarm-name "docqet-cpu-high" \
    --alarm-description "CPU utilization is high" \
    --metric-name "CPUUtilization" \
    --namespace "AWS/ECS" \
    --statistic "Average" \
    --period 300 \
    --threshold 80 \
    --comparison-operator "GreaterThanThreshold" \
    --evaluation-periods 2
```

### 5. CI/CD Pipeline Setup

#### GitHub Secrets Configuration
Configure the following secrets in your GitHub repository:

- `AWS_ACCESS_KEY_ID`: AWS access key for deployment
- `AWS_SECRET_ACCESS_KEY`: AWS secret key for deployment
- `SLACK_WEBHOOK_URL`: Slack webhook for notifications
- `DOCKERHUB_USERNAME`: Docker Hub username
- `DOCKERHUB_TOKEN`: Docker Hub access token

#### GitHub Environments
Create environments in GitHub:
1. Go to Settings > Environments
2. Create `staging` environment
3. Create `production` environment
4. Add protection rules as needed

### 6. Security Setup

#### SSL Certificate
```bash
# Request SSL certificate
aws acm request-certificate \
    --domain-name "docqet.example.com" \
    --validation-method DNS \
    --subject-alternative-names "*.docqet.example.com"
```

#### WAF Setup
```bash
# Create WAF web ACL
aws wafv2 create-web-acl \
    --name "docqet-waf" \
    --scope REGIONAL \
    --default-action Allow={} \
    --description "WAF for Docqet application"
```

## Deployment Workflow

### Development Workflow
1. **Local Development**
   ```bash
   make dev
   ```

2. **Testing**
   ```bash
   make test
   make ci
   ```

3. **Commit and Push**
   ```bash
   git add .
   git commit -m "Feature: your feature description"
   git push origin feature/your-feature
   ```

### Staging Deployment
1. **Merge to develop branch**
2. **Automatic deployment to staging**
3. **Run smoke tests**
4. **Manual verification**

### Production Deployment
1. **Create pull request to main**
2. **Code review and approval**
3. **Merge to main branch**
4. **Automatic deployment to production**
5. **Post-deployment verification**

## Monitoring and Observability

### Metrics to Monitor
- **Application Metrics**: Response times, error rates, throughput
- **Infrastructure Metrics**: CPU, memory, disk, network usage
- **Business Metrics**: User engagement, feature usage
- **Cost Metrics**: AWS resource utilization and costs

### Alerting Setup
- **Critical Alerts**: Service down, high error rates
- **Warning Alerts**: High resource usage, performance degradation
- **Info Alerts**: Deployment notifications, cost alerts

### Logging Strategy
- **Application Logs**: Structured JSON logging
- **Access Logs**: ALB and CloudFront access logs
- **Error Logs**: Sentry for error tracking
- **Audit Logs**: Security and compliance logging

## Cost Optimization

### Resource Optimization
- Right-sizing instances based on usage patterns
- Reserved instances for predictable workloads
- Spot instances for non-critical workloads
- Auto-scaling to match demand

### Storage Optimization
- S3 lifecycle policies for cost management
- CloudFront caching to reduce origin requests
- Database query optimization
- Efficient data retention policies

## Troubleshooting

### Common Issues

#### Terraform State Issues
```bash
# If state is locked
terraform force-unlock <lock-id>

# If state is corrupted
terraform init -reconfigure
```

#### ECS Deployment Issues
```bash
# Check service status
aws ecs describe-services --cluster docqet-cluster --services docqet-backend

# Check task logs
aws logs describe-log-groups --log-group-name-prefix /ecs/docqet
```

#### Database Connection Issues
```bash
# Check RDS status
aws rds describe-db-instances --db-instance-identifier docqet-db

# Test connectivity
aws rds describe-db-instances --db-instance-identifier docqet-db --query 'DBInstances[0].Endpoint'
```

### Support and Documentation
- **Documentation**: Comprehensive documentation in `/docs`
- **Runbooks**: Operational runbooks for common tasks
- **Slack**: Team communication and support
- **GitHub Issues**: Bug reports and feature requests

## Next Steps

### Immediate Actions
1. Set up AWS account and configure credentials
2. Create S3 backend for Terraform state
3. Configure environment variables
4. Deploy development environment
5. Set up monitoring and alerting

### Future Enhancements
1. **Kubernetes Migration**: Move from ECS to EKS
2. **Service Mesh**: Implement Istio
3. **GitOps**: Implement ArgoCD
4. **Multi-Cloud**: Support for additional cloud providers
5. **Edge Computing**: Lambda@Edge integration
6. **Machine Learning**: SageMaker integration

---

For additional support, refer to the main infrastructure documentation or create an issue in the repository. 