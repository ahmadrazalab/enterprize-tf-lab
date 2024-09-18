
variable "rds_identifier" {
  default = "rds-name-id"
}

variable "rds_subnet" {
  default = "rds-subnet-id"
}

# Try to find the latest snapshot
data "aws_db_snapshot" "latest" {
  most_recent            = true
  db_instance_identifier = var.rds_identifier
  snapshot_type          = "automated"
}

# Restore RDS instance only if a snapshot is found
resource "aws_db_instance" "restore_from_backup" {
  identifier           = var.rds_identifier
  snapshot_identifier  = data.aws_db_snapshot.latest.id
  instance_class       = "db.t3.medium"
  publicly_accessible  = false
  allocated_storage    = 100
  storage_type         = "gp3"
  skip_final_snapshot  = true
  db_subnet_group_name = var.rds_subnet

  engine               = "mysql"
  engine_version       = "8.0.23"
  username             = "admin"
  password             = "your_password"
  parameter_group_name = "default.mysql8.0"
}

# Output values if the RDS instance is created
output "db_instance_endpoint" {
  value = aws_db_instance.restore_from_backup[0].endpoint
}

output "db_instance_id" {
  value = aws_db_instance.restore_from_backup[0].id
}
