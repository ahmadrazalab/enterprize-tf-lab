# The /20 CIDR block gives each subnet 4096 IP addresses. This is more than enough for most applications.

# Public Subnets
#Subnet 1 (AZ1 - Public): 10.0.0.0/20 (4096 IPs)
#Subnet 2 (AZ2 - Public): 10.0.16.0/20 (4096 IPs)
#Subnet 3 (AZ3 - Public): 10.0.32.0/20 (4096 IPs)
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.0.0/20"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.16.0/20"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.32.0/20"
  availability_zone       = "ap-south-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-3"
  }
}


#Private Subnets
#Subnet 4 (AZ1 - Private): 10.0.48.0/20 (4096 IPs)
#Subnet 5 (AZ2 - Private): 10.0.64.0/20 (4096 IPs)
#Subnet 6 (AZ3 - Private): 10.0.80.0/20 (4096 IPs)
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = "10.0.48.0/20"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = "10.0.64.0/20"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = "10.0.80.0/20"
  availability_zone = "ap-south-1c"
  tags = {
    Name = "private-subnet-3"
  }
}