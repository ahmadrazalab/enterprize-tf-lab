variable "vpc_id" {
  description = "ID of the VPC to use for RDS instance creation"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instances"
  default     = "t3a.small"
}

variable "subnet_ids" {
  description = "A list of subnet IDs for RDS instance and read replica"
  type        = list(string)
}


variable "db-username" {
  default = "admin"
}
variable "db-password" {
  default = "Admin@123"
}
