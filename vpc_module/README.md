# VPC Module

This Terraform module creates a Virtual Private Cloud (VPC) in AWS with public and private subnets across multiple Availability Zones.

## Resources Created

- VPC
- Internet Gateway
- NAT Gateway
- Public and Private Subnets
- Route Tables (Public and Private)

## Usage

```hcl
module "vpc" {
  source = "path/to/vpc/module"

  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  private_subnet_cidrs = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
  availability_zones   = ["us-west-2a", "us-west-2b", "us-west-2c"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc_cidr | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| public_subnet_cidrs | CIDR blocks for public subnets | `list(string)` | `["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]` | no |
| private_subnet_cidrs | CIDR blocks for private subnets | `list(string)` | `["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]` | no |
| availability_zones | List of AZ names or IDs in the region | `list(string)` | n/a | yes |
| enable_dns_hostnames | Enable DNS hostnames in the VPC | `bool` | `true` | no |
| enable_dns_support | Enable DNS support in the VPC | `bool` | `true` | no |

#### 3. **Architecture Design**

Here’s a simple architecture for your VPC:

- **VPC (10.0.0.0/16)**
  - **Public Subnet 1** in **AZ1** (`10.0.0.0/20`)
  - **Public Subnet 2** in **AZ2** (`10.0.16.0/20`)
  - **Public Subnet 3** in **AZ3** (`10.0.32.0/20`)
  - **Private Subnet 1** in **AZ1** (`10.0.48.0/20`)
  - **Private Subnet 2** in **AZ2** (`10.0.64.0/20`)
  - **Private Subnet 3** in **AZ3** (`10.0.80.0/20`)

#### 4. **Additional Components to Consider**

- **Internet Gateway (IGW):** Attach an Internet Gateway to your VPC to allow communication with the internet. Only the public subnets will have routes to the IGW.
  
- **NAT Gateway or NAT Instance:** For instances in private subnets that need to access the internet for updates, a NAT Gateway is needed. This NAT Gateway is usually placed in one of the public subnets.

- **Route Tables:**
  - **Public Route Table:** Associated with public subnets, contains a route to the IGW.
  - **Private Route Table:** Associated with private subnets, contains a route to the NAT Gateway.

- **Security Groups and Network ACLs:** Set up security groups for instances and Network ACLs for the subnets to control traffic at different layers.

#### 5. **Implementing the VPC in AWS Console**

- **Create a VPC** with the CIDR block `10.0.0.0/16`.
- **Create Subnets**:
  - **3 Public Subnets** with the above CIDRs.
  - **3 Private Subnets** with the above CIDRs.
- **Attach an Internet Gateway** to the VPC.
- **Create a NAT Gateway** in one of the public subnets.
- **Create Route Tables**:
  - **Public Route Table** with a route to the Internet Gateway. Associate it with the public subnets.
  - **Private Route Table** with a route to the NAT Gateway. Associate it with the private subnets.

### Conclusion

This architecture allows you to have a secure and scalable environment in AWS, with segregation of public and private resources. The CIDR blocks are chosen to provide sufficient IP addresses while maintaining easy scalability.
