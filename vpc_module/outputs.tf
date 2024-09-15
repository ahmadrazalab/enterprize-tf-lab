output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.custom_vpc.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private_subnets[*].id
}

output "availability_zones" {
  description = "List of availability zones"
  value       = var.availability_zones
}