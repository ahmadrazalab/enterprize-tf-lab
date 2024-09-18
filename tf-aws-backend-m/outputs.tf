output "db_instance_endpoint" {
  value       = aws_db_instance.primary_db.endpoint
  description = "The connection endpoint of the primary RDS instance."
}

output "read_replica_endpoint" {
  value       = aws_db_instance.read_replica.endpoint
  description = "The connection endpoint of the read replica."
}