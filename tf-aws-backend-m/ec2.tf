
## Create EC2 instances
##############################################################################################################################################################

#Below is the EC2 of PROD ec2 instances of PP-TG primary
# resource "aws_instance" "app" {
#   count           = 1
#   ami             = var.ami_id
#   instance_type   = var.instance_type
#   key_name        = aws_key_pair.api-key-aws.key_name
#   subnet_id       = element(var.subnet_ids, count.index % length(var.subnet_ids))
#   security_groups = [aws_security_group.ec2_sg.id]
#   user_data = file("./resources/user-data.sh")    # user data file

#   tags = {
#     Name = "app-primary-instance-${count.index + 1}"
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
# }

# below is the EC2 of primart ec2 instances of PROD-TG primary
resource "aws_instance" "secondary_instance" {
  ami             = var.ami_id
  instance_type   = "t3a.small"
  key_name        = aws_key_pair.terraform-key.key_name
  subnet_id       = element(var.subnet_ids, 0)
  security_groups = [aws_security_group.ec2_sg.id]
  user_data       = file(var.user_data_script_path)

  tags = {
    Name = "${var.environment}-${replace(var.company_name, ".", "-")}-secondary-instance"
  }

}
