
# RDS mysql database 
##############################################################################################################################################################
resource "aws_db_instance" "default" {
  identifier              = "prod-db"
  allocated_storage       = 20
  max_allocated_storage   = 100
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.instance_type
  username                = var.db-username
  password                = var.db-password
  parameter_group_name    = "default.mysql8.0"
  skip_final_snapshot     = true
  publicly_accessible     = false
  deletion_protection     = false
  backup_retention_period = 1
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]

  tags = {
    Name = "prod-db"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = [var.subnet_ids[0]]
  vpc_id     = var.vpc_id

  tags = {
    Name = "main_db_subnet_group"
  }
}

resource "aws_db_subnet_group" "read_replica" {
  name       = "read-replica"
  subnet_ids = [var.subnet_ids[1]]
  vpc_id     = var.vpc_id

  tags = {
    Name = "read_replica_db_subnet_group"
  }
}



#########################################################################################
# Read Replica of the primary MySQL RDS instance in the same region
resource "aws_db_instance" "read_replica" {
  identifier             = "prod-db-replica"
  replicate_source_db    = aws_db_instance.default.identifier
  instance_class         = "db.t3.micro"
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.read_replica.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "prod-db-read-replica"
  }
}





