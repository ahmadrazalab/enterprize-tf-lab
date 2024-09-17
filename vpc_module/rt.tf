# Public Route Table with a route to the Internet Gateway. Associate it with the public subnets.
# Public Route Table: Associated with public subnets, contains a route to the IGW.

# Public Route Table
resource "aws_route_table" "prod_public_rt" {
  vpc_id = aws_vpc.prod_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_igw.id
  }
  tags = merge({
    Name = "prod-public-route-table"
  }, var.vpc_tags)
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "prod_public_rt_assoc" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.prod_public_subnets[count.index].id
  route_table_id = aws_route_table.prod_public_rt.id
}

# Private Route Table with a route to the NAT Gateway. Associate it with the private subnets.
# Private Route Table: Associated with private subnets, contains a route to the NAT Gateway.

# Private Route Table
resource "aws_route_table" "prod_private_rt" {
  vpc_id = aws_vpc.prod_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.prod_nat_gw.id
  }
  tags = merge({
    Name = "prod-private-route-table"
  }, var.vpc_tags)
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "prod_private_rt_assoc" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.prod_private_subnets[count.index].id
  route_table_id = aws_route_table.prod_private_rt.id
}
