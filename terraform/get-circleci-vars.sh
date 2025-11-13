#!/bin/bash

# Script to extract Terraform outputs for CircleCI configuration
# Run this after 'terraform apply' to get values for CircleCI environment variables

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "========================================="
echo "CircleCI Environment Variables"
echo "========================================="
echo ""
echo "Copy these values to your CircleCI project settings:"
echo ""
echo "--- Infrastructure Values (from Terraform) ---"
echo "S3_BUCKET_NAME=$(terraform output -raw s3_bucket_name 2>/dev/null || echo 'Not found')"
echo "EB_ENV_NAME=$(terraform output -raw elastic_beanstalk_environment 2>/dev/null || echo 'Not found')"
echo "EB_APP_NAME=$(terraform output -raw elastic_beanstalk_application 2>/dev/null || echo 'Not found')"
echo "POSTGRES_HOST=$(terraform output -raw rds_address 2>/dev/null || echo 'Not found')"
echo ""
echo "--- From terraform.tfvars (set these manually) ---"
echo "AWS_DEFAULT_REGION=$(grep '^aws_region' terraform.tfvars | cut -d'=' -f2 | tr -d ' "' || echo 'us-east-1')"
echo "POSTGRES_DB=$(grep '^db_name' terraform.tfvars | cut -d'=' -f2 | tr -d ' "' || echo 'postgres')"
echo "POSTGRES_USERNAME=$(grep '^db_username' terraform.tfvars | cut -d'=' -f2 | tr -d ' "' || echo 'postgres')"
echo "POSTGRES_PASSWORD=<from your terraform.tfvars file>"
echo "JWT_SECRET=<from your terraform.tfvars file>"
echo ""
echo "--- AWS Credentials (from AWS IAM) ---"
echo "AWS_ACCESS_KEY_ID=<your AWS access key>"
echo "AWS_SECRET_ACCESS_KEY=<your AWS secret key>"
echo ""
echo "========================================="
echo ""
echo "Additional Information:"
echo ""
echo "Frontend URL: $(terraform output -raw s3_website_url 2>/dev/null || echo 'Not found')"
echo "Backend URL:  $(terraform output -raw elastic_beanstalk_url 2>/dev/null || echo 'Not found')"
echo ""
