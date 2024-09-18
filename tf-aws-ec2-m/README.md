
# AWS EC2 Instance Module

This Terraform module creates EC2 instances with dedicated security groups and user data in AWS. It's designed to be flexible and reusable, allowing you to easily deploy and manage EC2 instances across different projects.

## Features

- Create multiple EC2 instances
- Configure a dedicated security group for the instances
- Apply user data to instances using a template
- Customize instance types, AMIs, and other parameters
- Apply common tags to all resources

## Usage

To use this module in your Terraform configuration:

1. Copy the module files to your project or reference it from a Git repository.
2. Create a `main.tf` file in your project directory and add the following code:

```hcl
module "ec2_instances" {
  source = "./path/to/ec2-module"

  aws_region           = "us-west-2"
  vpc_id               = "vpc-12345678"
  subnet_id            = "subnet-12345678"
  instance_count       = 2
  ami_id               = "ami-12345678"
  instance_type        = "t2.micro"
  key_name             = "my-key-pair"
  security_group_name  = "my-ec2-security-group"
  ingress_rules        = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  instance_name_prefix = "my-ec2-instance"
  user_data_template   = "user_data.tpl"
  user_data_vars       = {
    package_name = "nginx"
  }
  common_tags          = {
    Environment = "Development"
    Project     = "EC2Module"
  }
}

```

Run `terraform init` to initialize the module.

Run `terraform plan` to see the execution plan.

Run `terraform apply` to create the resources.

Customize the user data template ( user_data.tpl) to fit your specific needs.

>License
This module is released under the MIT License.


```bash
module "ec2_instances" {
  source = "./path/to/my-ec2-module"

  # You can override any variables here if needed
  aws_region           = "us-east-1"
  instance_count       = 3
  instance_type        = "t3.micro"
  # ... other variables
}
```