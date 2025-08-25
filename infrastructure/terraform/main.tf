# Docqet Infrastructure as Code
# Main Terraform configuration

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "docqet-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "docqet-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "docqet"
      Environment = var.environment
      ManagedBy   = "terraform"
      Owner       = "devops-team"
    }
  }
}

# Data sources
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# VPC and Networking
module "vpc" {
  source = "./modules/vpc"

  environment = var.environment
  vpc_cidr    = var.vpc_cidr
  azs         = var.availability_zones
}

# Security Groups
module "security_groups" {
  source = "./modules/security_groups"

  environment = var.environment
  vpc_id      = module.vpc.vpc_id
}

# RDS Database
module "database" {
  source = "./modules/database"

  environment     = var.environment
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  security_groups = [module.security_groups.database_sg_id]
  
  db_name     = var.database_name
  db_username = var.database_username
  db_password = var.database_password
  db_instance_class = var.database_instance_class
}

# ElastiCache Redis
module "redis" {
  source = "./modules/redis"

  environment     = var.environment
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  security_groups = [module.security_groups.redis_sg_id]
  
  redis_node_type = var.redis_node_type
}

# S3 Storage
module "storage" {
  source = "./modules/storage"

  environment = var.environment
  bucket_name = var.s3_bucket_name
}

# ECS Cluster and Services
module "ecs" {
  source = "./modules/ecs"

  environment     = var.environment
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
  
  security_groups = {
    alb = module.security_groups.alb_sg_id
    ecs = module.security_groups.ecs_sg_id
  }
  
  database_url = module.database.connection_string
  redis_url    = module.redis.connection_string
  s3_bucket    = module.storage.bucket_name
}

# Application Load Balancer
module "alb" {
  source = "./modules/alb"

  environment     = var.environment
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  security_groups = [module.security_groups.alb_sg_id]
  
  target_group_arns = module.ecs.target_group_arns
}

# CloudFront CDN
module "cloudfront" {
  source = "./modules/cloudfront"

  environment = var.environment
  domain_name = var.domain_name
  s3_bucket   = module.storage.bucket_name
}

# Route 53 DNS
module "dns" {
  source = "./modules/dns"

  environment = var.environment
  domain_name = var.domain_name
  
  alb_dns_name = module.alb.dns_name
  alb_zone_id  = module.alb.zone_id
  
  cloudfront_domain = module.cloudfront.domain_name
  cloudfront_zone_id = module.cloudfront.zone_id
}

# Monitoring and Logging
module "monitoring" {
  source = "./modules/monitoring"

  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  
  ecs_cluster_name = module.ecs.cluster_name
  alb_arn          = module.alb.arn
  rds_identifier   = module.database.identifier
}

# Secrets Management
module "secrets" {
  source = "./modules/secrets"

  environment = var.environment
  
  database_password = var.database_password
  jwt_secret        = var.jwt_secret
  api_keys          = var.api_keys
}

# Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS name"
  value       = module.alb.dns_name
}

output "database_endpoint" {
  description = "RDS database endpoint"
  value       = module.database.endpoint
  sensitive   = true
}

output "redis_endpoint" {
  description = "ElastiCache Redis endpoint"
  value       = module.redis.endpoint
  sensitive   = true
}

output "s3_bucket_name" {
  description = "S3 bucket name for document storage"
  value       = module.storage.bucket_name
}

output "cloudfront_domain" {
  description = "CloudFront distribution domain"
  value       = module.cloudfront.domain_name
}

output "domain_name" {
  description = "Application domain name"
  value       = module.dns.domain_name
} 