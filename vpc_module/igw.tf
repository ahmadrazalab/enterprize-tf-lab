# Internet Gateway (IGW): Attach an Internet Gateway to your VPC to allow communication with the internet. Only the public subnets will have routes to the IGW.
# Attach an Internet Gateway to the VPC.


# Create Internet Gateway
resource "aws_internet_gateway" "prod_igw" {
  vpc_id = aws_vpc.prod_vpc.id
  tags = merge({
    Name = "prod-vpc-igw"
  }, var.vpc_tags)
}