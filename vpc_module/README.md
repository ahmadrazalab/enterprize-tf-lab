### Step-by-Step Guide to Create a Custom VPC

#### 1. **Choose a CIDR Block for Your VPC**

A VPC (Virtual Private Cloud) CIDR block is a range of IP addresses. When creating a VPC, you need to decide on the size of the IP address range.

- **CIDR Block for VPC**: For this example, we'll use `10.0.0.0/16`. This provides a range of IP addresses from `10.0.0.0` to `10.0.255.255`, giving us 65,536 IP addresses.

#### 2. **Divide the VPC CIDR Block into Subnets**

You need to divide the VPC into smaller subnets. Each subnet will be associated with an AZ. Since we want 3 public and 3 private subnets, we can allocate the CIDR ranges accordingly.

##### **Public Subnets**

- **Subnet 1 (AZ1 - Public)**: `10.0.0.0/20` (4096 IPs)
- **Subnet 2 (AZ2 - Public)**: `10.0.16.0/20` (4096 IPs)
- **Subnet 3 (AZ3 - Public)**: `10.0.32.0/20` (4096 IPs)

##### **Private Subnets**

- **Subnet 4 (AZ1 - Private)**: `10.0.48.0/20` (4096 IPs)
- **Subnet 5 (AZ2 - Private)**: `10.0.64.0/20` (4096 IPs)
- **Subnet 6 (AZ3 - Private)**: `10.0.80.0/20` (4096 IPs)

The `/20` CIDR block gives each subnet 4096 IP addresses. This is more than enough for most applications.

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
