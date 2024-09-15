terraform {
  required_version = "~> 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    Environment = "Production"
    Project     = "MyProject"
    Region      = "ap-south-1"
  }
}

# creating vpc resources for network isolation
module "vpc" {
  source = "./vpc_module"
  
  region               = var.region
  vpc_cidr             = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

# creating frontend resources with static sites
module "frontend" {
  source             = "./frontend_module"
  
  region             = var.region
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  availability_zones = var.availability_zones
  certificate_arn    = var.certificate_arn
}

# creating backend resources with ec2 alb
module "backend" {
  source             = "./backend_module"
  
  region             = var.region
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  availability_zones = var.availability_zones
  certificate_arn    = var.certificate_arn
  ec2_ami            = var.ec2_ami
  ec2_instance_type  = var.ec2_instance_type
}

# creating custom resources 
# Removed temporary module
# module "temp_resource" {
#   source  = "./temp_modules"
#   vpc_id  = module.vpc.vpc_id
# }