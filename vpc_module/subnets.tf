# The /20 CIDR block gives each subnet 4096 IP addresses. This is more than enough for most applications.

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
  default     = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
  default     = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

# Public Subnets
#Subnet 1 (AZ1 - Public): 10.0.0.0/20 (4096 IPs)
#Subnet 2 (AZ2 - Public): 10.0.16.0/20 (4096 IPs)
#Subnet 3 (AZ3 - Public): 10.0.32.0/20 (4096 IPs)
resource "aws_subnet" "prod_public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.prod_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "prod-public-subnet-${count.index + 1}"
  }
}


#Private Subnets
#Subnet 4 (AZ1 - Private): 10.0.48.0/20 (4096 IPs)
#Subnet 5 (AZ2 - Private): 10.0.64.0/20 (4096 IPs)
#Subnet 6 (AZ3 - Private): 10.0.80.0/20 (4096 IPs)
resource "aws_subnet" "prod_private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "prod-private-subnet-${count.index + 1}"
  }
}