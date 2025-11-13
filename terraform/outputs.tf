output "s3_bucket_name" {
  description = "Name of the S3 bucket hosting the frontend"
  value       = aws_s3_bucket.frontend.bucket
}

output "s3_website_url" {
  description = "URL of the S3 website"
  value       = "http://${aws_s3_bucket.frontend.bucket}.s3-website-${var.aws_region}.amazonaws.com"
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.frontend.arn
}

output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.postgres.endpoint
}

output "rds_address" {
  description = "RDS PostgreSQL address"
  value       = aws_db_instance.postgres.address
}

output "rds_port" {
  description = "RDS PostgreSQL port"
  value       = aws_db_instance.postgres.port
}

output "elastic_beanstalk_application" {
  description = "Elastic Beanstalk application name"
  value       = aws_elastic_beanstalk_application.app.name
}

output "elastic_beanstalk_environment" {
  description = "Elastic Beanstalk environment name"
  value       = aws_elastic_beanstalk_environment.app_env.name
}

output "elastic_beanstalk_url" {
  description = "Elastic Beanstalk environment URL"
  value       = aws_elastic_beanstalk_environment.app_env.endpoint_url
}

output "elastic_beanstalk_cname" {
  description = "Elastic Beanstalk environment CNAME"
  value       = aws_elastic_beanstalk_environment.app_env.cname
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = aws_subnet.private[*].id
}
