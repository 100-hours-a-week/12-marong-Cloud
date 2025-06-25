# VPC 생성
resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = var.name
  }
}

# Internet Gateway 생성
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = var.name
  }
}

# Public Subnet 생성 (10.0.1.0/24, 가용 영역 2개)
locals {
  azs = ["ap-northeast-2a", "ap-northeast-2c"]
}

// Public Subnet 생성
resource "aws_subnet" "public_subnet" {
  for_each = {
    for idx, az in local.azs :
    az => cidrsubnet(var.cidr_block, 8, idx)
  }
  vpc_id = aws_vpc.this.id
  cidr_block = each.value
  availability_zone = each.key
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${each.key}"
  }
}

// Public Route Table 생성
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "public-route-table"
  }
}

// Public Subnet에 IGW 연결
resource "aws_route" "public_igw" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this.id
}

// Public Subnet에 Route Table 연결
resource "aws_route_table_association" "public_subnet_association" {
  for_each = aws_subnet.public_subnet
  subnet_id = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

// k8s 구동을 위한 WAS subnet 생성
resource "aws_subnet" "was_subnet" {
  for_each = {
    for idx, az in local.azs :
    az => cidrsubnet(var.cidr_block, 8, idx + 2)
  }
  vpc_id = aws_vpc.this.id
  cidr_block = each.value
  availability_zone = each.key
  tags = {
    Name = "was-subnet-${each.key}"
  }
}

// WAS route table 생성
resource "aws_route_table" "was_route_table" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "was-route-table"
  }
}

// WAS route table에 NAT Gateway 연결
resource "aws_route" "was_nat_gateway" {
  route_table_id = aws_route_table.was_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateway.id
}

// WAS subnet에 route table 연결
resource "aws_route_table_association" "was_subnet_association" {
  for_each = aws_subnet.was_subnet
  subnet_id = each.value.id
  route_table_id = aws_route_table.was_route_table.id
}

// NAT Gateway 위한 EIP 생성
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "nat-eip"
  }
}

// NAT Gateway 생성
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public_subnet["ap-northeast-2a"].id
  tags = {
    Name = "nat-gateway"
  }
}

// DB를 놓을 private subnet 생성
resource "aws_subnet" "private_subnet" {
  for_each = {
    for idx, az in local.azs :
    az => cidrsubnet(var.cidr_block, 8, idx + 4)
  }
  vpc_id = aws_vpc.this.id
  cidr_block = each.value
  availability_zone = each.key
  tags = {
    Name = "private-subnet-${each.key}"
  }
}

// private route table 생성
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "private-route-table"
  }
}

// private subnet에 route table 연결
resource "aws_route_table_association" "private_subnet_association" {
  for_each = aws_subnet.private_subnet
  subnet_id = each.value.id
  route_table_id = aws_route_table.private_route_table.id
}