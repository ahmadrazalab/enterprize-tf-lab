#NAT Gateway or NAT Instance: For instances in private subnets that need to access the internet for updates, a NAT Gateway is needed. This NAT Gateway is usually placed in one of the public subnets.
# Create a NAT Gateway in one of the public subnets.

# Create NAT Gateway in a Public Subnet
resource "aws_eip" "prod_nat_eip" {
  domain = "vpc"
  tags = merge({
    Name = "prod-nat-eip"
  }, var.vpc_tags)
}

resource "aws_nat_gateway" "prod_nat_gw" {
  allocation_id = aws_eip.prod_nat_eip.id
  subnet_id     = aws_subnet.prod_public_subnets[0].id
  tags = merge({
    Name = "prod-nat-gateway"
  }, var.vpc_tags)
}
