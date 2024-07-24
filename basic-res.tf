# Creating AWS key pair for Ec2 instance
resource "aws_key_pair" "api-key-aws" {
  key_name   = "api-key-aws"
  public_key = file("./resources/id_rsa.pub")
}
