module "ec2_instances" {
  source = "./path/to/my-ec2-module"

  # You can override any variables here if needed
  aws_region           = "us-east-1"
  instance_count       = 3
  instance_type        = "t3.micro"
  # ... other variables
}
