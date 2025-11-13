#!/bin/bash

# Terraform Destroy Script
# This script destroys all AWS resources created by Terraform

set -e  # Exit on error

echo "========================================="
echo "Terraform Infrastructure Teardown"
echo "========================================="
echo ""
echo "WARNING: This will destroy all AWS resources!"
echo "This includes:"
echo "  - S3 Bucket (and all files)"
echo "  - RDS Database (and all data)"
echo "  - Elastic Beanstalk Application and Environment"
echo "  - VPC and all networking components"
echo ""

# Check if terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "Error: Terraform is not installed."
    exit 1
fi

# Navigate to terraform directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Check if terraform state exists
if [ ! -f "terraform.tfstate" ]; then
    echo "No Terraform state found. Nothing to destroy."
    exit 0
fi

read -p "Are you absolutely sure you want to destroy all resources? Type 'destroy' to confirm: " confirm

if [ "$confirm" != "destroy" ]; then
    echo "Teardown cancelled."
    exit 0
fi

echo ""
echo "Step 1: Planning destruction..."
terraform plan -destroy -out=destroy.tfplan

echo ""
echo "Step 2: Destroying infrastructure..."
terraform apply destroy.tfplan

echo ""
echo "========================================="
echo "Teardown Complete!"
echo "========================================="
echo ""
echo "All AWS resources have been destroyed."
echo ""

# Clean up files
rm -f destroy.tfplan
rm -f outputs.json
rm -f outputs.txt

echo "Cleanup complete."
