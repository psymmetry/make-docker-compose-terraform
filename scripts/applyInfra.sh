#!/bin/bash
set -e

# Environment Variables
ENVIRONMENT=${ENVIRONMENT:=dev}
TF_BACKEND_CONFIG=config/${ENVIRONMENT}/${ENVIRONMENT}.backend
TF_VARIABLES=config/${ENVIRONMENT}/${ENVIRONMENT}.tfvars

cd infra/

# Run Terraform init using backend config
terraform init \
    -backend-config="${TF_BACKEND_CONFIG}" \
    -reconfigure

# Run Terraform apply
terraform apply -auto-approve -var-file="${TF_VARIABLES}"
