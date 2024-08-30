
# RDS mysql database 
##############################################################################################################################################################
resource "aws_db_instance" "default" {
  identifier             = "app-db-nest" # Set your DB identifier here
  allocated_storage      = 20
  max_allocated_storage  = 100
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "password"
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  publicly_accessible    = false
  deletion_protection    = false # normally its true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  tags = {
    Name = "app-db-"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "aws_db_subnet_group"
  }
}


# Read Replica of the primary MySQL RDS instance in the same region
resource "aws_db_instance" "read_replica" {
  identifier             = "app-db-replica"
  replicate_source_db    = aws_db_instance.default.identifier
  instance_class         = "db.t3.micro"
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "app-db-read-replica"
  }
}

