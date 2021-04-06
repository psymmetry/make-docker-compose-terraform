.SILENT:

# Default variables
ENVIRONMENT ?= dev

# Terraform related configuration
TF_STATE_KEY = examples-make-docker-compose-terraform.tfstate
TF_BACKEND_CONFIG = config/$(ENVIRONMENT)/$(ENVIRONMENT).backend
TF_VARIABLES = config/$(ENVIRONMENT)/$(ENVIRONMENT).tfvars
TF_PLAN = $(ENVIRONMENT)-terraform.plan

# Initialise Terraform state file
init: clean
	docker-compose run \
		--rm \
		--entrypoint terraform \
		terraform init -backend-config=$(TF_BACKEND_CONFIG) -backend-config=key=$(TF_STATE_KEY) -reconfigure

# Validate syntax on current Terraform configuration
validate: 
	echo "Validating Terraform Configuration"
	docker-compose run \
		--rm \
		--entrypoint terraform \
		terraform init -input=false -backend=false -lock=false
	docker-compose run \
		--rm \
		--entrypoint terraform \
		terraform validate

# Generate a Terraform plan as an output file
plan: init
	echo "Building Terraform Plan"
	docker-compose run \
		--rm \
		--entrypoint terraform \
		terraform plan -var-file=$(TF_VARIABLES) -out $(TF_PLAN)

# Run compliance rules against Terraform plan file
comply:
	echo "Running Terraform Compliance Rules"
	docker-compose run \
		--rm \
		--entrypoint terraform-compliance \
		terraform-compliance --planfile $(TF_PLAN) --features /app/infra/tests/compliance

# Deploy infrastructure with an expected Terraform plan file
apply: plan
	echo "Deploying Terraform Plan"
	docker-compose run \
		--rm \
		--entrypoint terraform \
		terraform apply -auto-approve -var-file=$(TF_VARIABLES)

# Destroy Terraform deployed resources
destroy: init
	echo "Destroying Terraform Infrastructure"
	docker-compose run \
		--rm \
		--entrypoint terraform \
		terraform destroy -auto-approve

# Remove left over terraform configuration and any left over docker networks
clean:
	echo "Removing terraform config and removing orphaned docker networks"
	docker-compose run \
		--entrypoint="rm -rf .terraform" terraform
	docker-compose down \
		--remove-orphans 2>/dev/null
