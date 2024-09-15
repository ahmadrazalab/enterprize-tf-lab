#NAT Gateway or NAT Instance: For instances in private subnets that need to access the internet for updates, a NAT Gateway is needed. This NAT Gateway is usually placed in one of the public subnets.
# Create a NAT Gateway in one of the public subnets.

# Create NAT Gateway in a Public Subnet
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name = "nat-gateway"
  }
}
