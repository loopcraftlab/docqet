# Docqet Infrastructure Variables

variable "environment" {
  description = "Environment name (dev, staging, production)"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "Environment must be one of: dev, staging, production."
  }
}

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones for the region"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# Database Configuration
variable "database_name" {
  description = "Name of the database"
  type        = string
  default     = "docqet"
}

variable "database_username" {
  description = "Database master username"
  type        = string
  default     = "docqet_admin"
  sensitive   = true
}

variable "database_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

variable "database_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
  
  validation {
    condition     = can(regex("^db\\.[a-z0-9]+\\.[a-z0-9]+$", var.database_instance_class))
    error_message = "Database instance class must be a valid AWS RDS instance class."
  }
}

# Redis Configuration
variable "redis_node_type" {
  description = "ElastiCache Redis node type"
  type        = string
  default     = "cache.t3.micro"
}

# Storage Configuration
variable "s3_bucket_name" {
  description = "S3 bucket name for document storage"
  type        = string
  default     = "docqet-documents"
  
  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.s3_bucket_name))
    error_message = "S3 bucket name must be valid (lowercase, no underscores, 3-63 characters)."
  }
}

# Domain Configuration
variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = "docqet.example.com"
}

# ECS Configuration
variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "docqet-cluster"
}

variable "ecs_service_desired_count" {
  description = "Desired number of ECS service instances"
  type        = number
  default     = 2
  
  validation {
    condition     = var.ecs_service_desired_count >= 1
    error_message = "ECS service desired count must be at least 1."
  }
}

variable "ecs_task_cpu" {
  description = "CPU units for ECS task (1024 = 1 vCPU)"
  type        = number
  default     = 256
  
  validation {
    condition     = contains([256, 512, 1024, 2048, 4096], var.ecs_task_cpu)
    error_message = "ECS task CPU must be one of: 256, 512, 1024, 2048, 4096."
  }
}

variable "ecs_task_memory" {
  description = "Memory for ECS task in MiB"
  type        = number
  default     = 512
  
  validation {
    condition     = var.ecs_task_memory >= 512
    error_message = "ECS task memory must be at least 512 MiB."
  }
}

# Auto Scaling Configuration
variable "enable_auto_scaling" {
  description = "Enable auto scaling for ECS services"
  type        = bool
  default     = true
}

variable "min_capacity" {
  description = "Minimum number of ECS service instances"
  type        = number
  default     = 1
  
  validation {
    condition     = var.min_capacity >= 1
    error_message = "Minimum capacity must be at least 1."
  }
}

variable "max_capacity" {
  description = "Maximum number of ECS service instances"
  type        = number
  default     = 10
  
  validation {
    condition     = var.max_capacity >= var.min_capacity
    error_message = "Maximum capacity must be greater than or equal to minimum capacity."
  }
}

# Monitoring Configuration
variable "enable_monitoring" {
  description = "Enable CloudWatch monitoring and alerting"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "Enable CloudWatch logging"
  type        = bool
  default     = true
}

# Security Configuration
variable "enable_waf" {
  description = "Enable AWS WAF for web application protection"
  type        = bool
  default     = true
}

variable "enable_ssl" {
  description = "Enable SSL/TLS encryption"
  type        = bool
  default     = true
}

# Secrets Configuration
variable "jwt_secret" {
  description = "JWT secret for authentication"
  type        = string
  sensitive   = true
}

variable "api_keys" {
  description = "API keys for external services"
  type        = map(string)
  default     = {}
  sensitive   = true
}

# Backup Configuration
variable "enable_backup" {
  description = "Enable automated backups"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
  
  validation {
    condition     = var.backup_retention_period >= 1 && var.backup_retention_period <= 35
    error_message = "Backup retention period must be between 1 and 35 days."
  }
}

# Cost Optimization
variable "enable_cost_optimization" {
  description = "Enable cost optimization features"
  type        = bool
  default     = true
}

variable "use_spot_instances" {
  description = "Use spot instances for non-critical workloads"
  type        = bool
  default     = false
}

# Tags
variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Project     = "docqet"
    ManagedBy   = "terraform"
    Owner       = "devops-team"
    CostCenter  = "engineering"
  }
}

# Environment-specific overrides
locals {
  # Environment-specific configurations
  environment_configs = {
    dev = {
      database_instance_class = "db.t3.micro"
      redis_node_type        = "cache.t3.micro"
      ecs_task_cpu           = 256
      ecs_task_memory        = 512
      ecs_service_desired_count = 1
      min_capacity           = 1
      max_capacity           = 3
      enable_auto_scaling    = false
      enable_monitoring      = false
      enable_waf             = false
      enable_backup          = false
    }
    
    staging = {
      database_instance_class = "db.t3.small"
      redis_node_type        = "cache.t3.small"
      ecs_task_cpu           = 512
      ecs_task_memory        = 1024
      ecs_service_desired_count = 2
      min_capacity           = 1
      max_capacity           = 5
      enable_auto_scaling    = true
      enable_monitoring      = true
      enable_waf             = false
      enable_backup          = true
    }
    
    production = {
      database_instance_class = "db.t3.medium"
      redis_node_type        = "cache.t3.medium"
      ecs_task_cpu           = 1024
      ecs_task_memory        = 2048
      ecs_service_desired_count = 3
      min_capacity           = 2
      max_capacity           = 10
      enable_auto_scaling    = true
      enable_monitoring      = true
      enable_waf             = true
      enable_backup          = true
    }
  }
  
  # Apply environment-specific overrides
  config = local.environment_configs[var.environment]
} 