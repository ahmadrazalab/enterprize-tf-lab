output "instance_ids" {
  description = "IDs of the created EC2 instances"
  value       = aws_instance.ec2_instances[*].id
}

output "instance_public_ips" {
  description = "Public IPs of the created EC2 instances"
  value       = aws_instance.ec2_instances[*].public_ip
}

output "security_group_id" {
  description = "ID of the created security group"
  value       = aws_security_group.ec2_sg.ingress
}
