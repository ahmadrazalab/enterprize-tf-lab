# Removed Terraform Cloud configuration


terraform {
  required_version = "~> 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31"
    }
  }
}

# Configure the AWS Provider cli with region hard code 
# Provider configuration is inherited from the root module
