#!/bin/bash
set -e

# Environment Variables
ENVIRONMENT=${ENVIRONMENT:=dev}
TF_BACKEND_CONFIG=config/${ENVIRONMENT}/${ENVIRONMENT}.backend
TF_VARIABLES=config/${ENVIRONMENT}/${ENVIRONMENT}.tfvars
TF_PLAN=${ENVIRONMENT}-terraform.plan

cd infra/

# Run Terraform init using backend config
terraform init \
    -backend-config=${TF_BACKEND_CONFIG} \
    -reconfigure 

# Run Terraform plan
terraform plan -var-file=${TF_VARIABLES} -out ${TF_PLAN}

# Run Terraform Compliance tests
terraform-compliance --planfile "${TF_PLAN}" --features /app/rules
