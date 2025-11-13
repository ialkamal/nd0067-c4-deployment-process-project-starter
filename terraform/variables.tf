variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name to be used for resource naming"
  type        = string
  default     = "udagram"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# S3 Variables
variable "s3_bucket_name" {
  description = "Name of the S3 bucket for frontend hosting"
  type        = string
}

# RDS Variables
variable "db_identifier" {
  description = "RDS database identifier"
  type        = string
  default     = "udagram-db"
}

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
  default     = "postgres"
}

variable "db_username" {
  description = "PostgreSQL master username"
  type        = string
  default     = "postgres"
  sensitive   = true
}

variable "db_password" {
  description = "PostgreSQL master password"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage for RDS in GB"
  type        = number
  default     = 20
}

variable "db_engine_version" {
  description = "PostgreSQL engine version"
  type        = string
  default     = "15"
}

# Elastic Beanstalk Variables
variable "eb_application_name" {
  description = "Elastic Beanstalk application name"
  type        = string
  default     = "udagram-api"
}

variable "eb_environment_name" {
  description = "Elastic Beanstalk environment name"
  type        = string
  default     = "udagram-api-dev"
}

variable "eb_solution_stack" {
  description = "Elastic Beanstalk solution stack"
  type        = string
  default     = "64bit Amazon Linux 2023 v6.6.8 running Node.js 20"
}

variable "eb_instance_type" {
  description = "EC2 instance type for Elastic Beanstalk"
  type        = string
  default     = "t2.small"
}

# JWT Secret
variable "jwt_secret" {
  description = "JWT secret for authentication"
  type        = string
  sensitive   = true
}
