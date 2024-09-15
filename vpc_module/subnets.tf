# The /20 CIDR block gives each subnet 4096 IP addresses. This is more than enough for most applications.

# Public Subnets
#Subnet 1 (AZ1 - Public): 10.0.0.0/20 (4096 IPs)
#Subnet 2 (AZ2 - Public): 10.0.16.0/20 (4096 IPs)
#Subnet 3 (AZ3 - Public): 10.0.32.0/20 (4096 IPs)
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}


#Private Subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}