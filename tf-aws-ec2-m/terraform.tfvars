aws_region           = "ap-south-1"
vpc_id               = "vpc-12345678"
subnet_id            = "subnet-12345678"
instance_count       = 2
ami_id               = "ami-12345678"
instance_type        = "t2.micro"
key_name             = "my-key-pair"
security_group_name  = "my-ec2-security-group"
ingress_rules = [
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
instance_name_prefix = "tf-ec2-instance"
user_data_template   = "user_data.tpl"
common_tags = {
  Environment = "Development"
  Project     = "EC2Module"
}
