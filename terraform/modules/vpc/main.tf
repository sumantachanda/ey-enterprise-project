# The Virtual Private Cloud (VPC)
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name                                           = "ey-enterprise-vpc"
    "kubernetes.io/cluster/ey-enterprise-cluster" = "shared"
  }
}

# Public Subnet (For our Jenkins Server/Gateways)
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}a"

  tags = {
    Name                                           = "ey-public-subnet"
    "kubernetes.io/cluster/ey-enterprise-cluster" = "shared"
    "kubernetes.io/role/elb"                       = "1"
  }
}

# Private Subnet 1 (For our EKS Cluster - Extra Secure)
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name                                           = "ey-private-subnet-1"
    "kubernetes.io/cluster/ey-enterprise-cluster" = "shared"
    "kubernetes.io/role/internal-elb"              = "1"
  }
}

# Private Subnet 2 (Required for EKS High Availability)
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name                                           = "ey-private-subnet-2"
    "kubernetes.io/cluster/ey-enterprise-cluster" = "shared"
    "kubernetes.io/role/internal-elb"              = "1"
  }
}

# The Internet Gateway (The Road to the World)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ey-igw"
  }
}

# Public Subnet 2 (Required for EKS High Availability in Public Mode)
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.10.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}b"

  tags = {
    Name                                           = "ey-public-subnet-2"
    "kubernetes.io/cluster/ey-enterprise-cluster" = "shared"
    "kubernetes.io/role/elb"                       = "1"
  }
}

# Variables for the module
variable "region" {}

# The Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "ey-public-rt"
  }
}

# Associate the Public Subnets with the Route Table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}
