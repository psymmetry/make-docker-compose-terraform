terraform {
    required_version = "~> 0.14.6"

    backend "s3" {
        encrypt = "true"
    }

    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = var.region
}
