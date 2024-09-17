
# RDS mysql database 
##############################################################################################################################################################
resource "aws_db_instance" "primary_db" {
  identifier             = "${var.environment}-${replace(var.company_name, ".", "-")}-primary-db"
  allocated_storage      = var.db_allocated_storage
  max_allocated_storage  = var.db_max_allocated_storage
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  username               = "admin"
  password               = "password"
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  publicly_accessible    = false
  deletion_protection    = false # normally its true
  # setup automateed backups rentention for 1 days
  backup_retention_period = 7 # required fo rread replica 
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name

  tags = {
    Name        = "${var.environment}-${replace(var.company_name, ".", "-")}-primary-db"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.environment}-${replace(var.company_name, ".", "-")}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "${var.environment}-${replace(var.company_name, ".", "-")}-db-subnet-group"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

#########################################################################################
# Read Replica of the primary MySQL RDS instance in the same region
resource "aws_db_instance" "read_replica" {
  identifier             = "${var.environment}-${replace(var.company_name, ".", "-")}-db-replica"
  replicate_source_db    = aws_db_instance.primary_db.identifier
  instance_class         = "db.t3.small"
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "app-db-read-replica"
  }
}





