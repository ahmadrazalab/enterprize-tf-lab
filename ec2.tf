
## Create EC2 instances
##############################################################################################################################################################
resource "aws_instance" "app" {
  count           = 1
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.api-key-aws.key_name
  subnet_id       = element(var.subnet_ids, count.index % length(var.subnet_ids))
  security_groups = [aws_security_group.ec2_sg.id]
  user_data = file("./resources/user-data.sh")    # user data file

  tags = {
    Name = "app-primary-instance-${count.index + 1}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "tg2" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.api-key-aws.key_name
  subnet_id       = element(var.subnet_ids, 0)
  security_groups = [aws_security_group.ec2_sg.id]
  user_data = file("./resources/user-data.sh")    # user data file

  tags = {
    Name = "app-seconday-instance-tg2"
  }
  lifecycle {
    create_before_destroy = true
  }

}
