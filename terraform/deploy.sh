#!/bin/bash

# Terraform Deploy Script
# This script initializes and applies Terraform configuration to provision AWS resources

set -e  # Exit on error

echo "========================================="
echo "Terraform Infrastructure Deployment"
echo "========================================="

# Check if terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "Error: Terraform is not installed. Please install Terraform first."
    echo "Visit: https://www.terraform.io/downloads"
    exit 1
fi

# Navigate to terraform directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Check if terraform.tfvars exists
if [ ! -f "terraform.tfvars" ]; then
    echo "Error: terraform.tfvars not found!"
    echo "Please copy terraform.tfvars.example to terraform.tfvars and fill in your values:"
    echo "  cp terraform.tfvars.example terraform.tfvars"
    echo "Then edit terraform.tfvars with your configuration."
    exit 1
fi

echo ""
echo "Step 1: Initializing Terraform..."
terraform init

echo ""
echo "Step 2: Validating Terraform configuration..."
terraform validate

echo ""
echo "Step 3: Planning infrastructure changes..."
terraform plan -out=tfplan

echo ""
echo "========================================="
echo "Review the plan above."
read -p "Do you want to apply these changes? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "Deployment cancelled."
    rm -f tfplan
    exit 0
fi

echo ""
echo "Step 4: Applying Terraform configuration..."
terraform apply tfplan

echo ""
echo "Step 5: Saving outputs..."
terraform output -json > outputs.json
terraform output > outputs.txt

echo ""
echo "========================================="
echo "Deployment Complete!"
echo "========================================="
echo ""
echo "Your infrastructure has been provisioned:"
echo ""
terraform output
echo ""
echo "Important: Save the outputs above for your CircleCI environment variables."
echo "Outputs have been saved to:"
echo "  - outputs.json (JSON format)"
echo "  - outputs.txt (Human readable)"
echo ""

# Clean up plan file
rm -f tfplan

echo "Next steps:"
echo "1. Note the S3 bucket name and Elastic Beanstalk environment name"
echo "2. Configure CircleCI environment variables with these values"
echo "3. Push your code to trigger the CircleCI pipeline"
