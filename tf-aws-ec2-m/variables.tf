variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the EC2 instances will be created"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instances will be created"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "security_group_name" {
  description = "Name of the security group for EC2 instances"
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "instance_name_prefix" {
  description = "Prefix for EC2 instance names"
  type        = string
}

variable "user_data_template" {
  description = "Path to the user data template file"
  type        = string
}

variable "user_data_vars" {
  description = "Variables to be passed to the user data template"
  type        = map(string)
  default     = {}
}

variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {}
}
