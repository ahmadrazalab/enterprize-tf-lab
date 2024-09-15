
# Variables of N.virginia.US
variable "ami_id" {
  default     = "ami-0c2af51e265bd5e0e"
  description = "The AMI ID for the EC2 instances"
}

variable "instance_type" {
  description = "The instance type for the EC2 instances"
  default     = "t3a.small"
}

variable "vpc_id" {
  default     = "vpc-06661c84c2baeb1ad"
  description = "The Default VPC ID"
}

variable "subnet_ids" {
  description = "A list of subnet IDs"
  type        = list(string)
  default     = ["subnet-015a40d5f423f524a", "subnet-0290c587dafefc1e0", "subnet-0b8b4c5497fa8fd25"]
}

# tf wars variables
variable "certificate_arn" {
  description = "The ARN of the ACM certificate to use for the HTTPS listener"
  type        = string
}
