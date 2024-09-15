# Internet Gateway (IGW): Attach an Internet Gateway to your VPC to allow communication with the internet. Only the public subnets will have routes to the IGW.
# Attach an Internet Gateway to the VPC.


# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "custom-vpc-igw"
  }
}