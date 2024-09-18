provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "ec2_sg" {
  name        = var.security_group_name
  description = "Security group for EC2 instances"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = var.security_group_name
    }
  )
}

resource "aws_instance" "ec2_instances" {
  count                  = var.instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id              = var.subnet_id

  user_data = base64encode(templatefile(var.user_data_template, var.user_data_vars))

  tags = merge(
    var.common_tags,
    {
      Name = "${var.instance_name_prefix}-${count.index + 1}"
    }
  )
}
