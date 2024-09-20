# RDS Module

This Terraform module creates an Amazon RDS MySQL instance with a read replica in a custom VPC.

## Usage

```hcl
module "rds" {
  source = "path/to/module"

  vpc_id     = "vpc-xxxxxxxx"
  subnet_ids = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"]

  # Other variables as needed
}
```

## Variables

- `vpc_id`: ID of the VPC to use for RDS instance creation
- `subnet_ids`: List of subnet IDs for RDS instance and read replica
- `instance_type`: RDS instance type (default: "db.t3.micro")
- `db-username`: Database username
- `db-password`: Database password

## Outputs

- `db_instance_endpoint`: The connection endpoint for the primary RDS instance
- `db_instance_name`: The database name of the primary RDS instance
- `read_replica_endpoint`: The connection endpoint for the read replica RDS instance

## Description

This module creates:
1. A primary RDS MySQL instance
2. A read replica of the primary instance
3. DB subnet groups for both instances
4. Security group for RDS instances

The primary instance and read replica are created in different subnets within the specified VPC for improved availability and performance.