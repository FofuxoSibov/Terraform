# VPC
resource "aws_vpc" "VPC-CloudPlay" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = "VPC-CloudPlay"
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "IGW-CloudPlay" {
  vpc_id = aws_vpc.VPC-CloudPlay.id

  tags = {
    Name = "IGW-CloudPlay"
  }
}

# SUBNET Subrede-Pub1
resource "aws_subnet" "Subrede-Pub1" {
  vpc_id                  = aws_vpc.VPC-CloudPlay.id
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Subrede-Pub1"
  }
}

# SUBNET Subrede-Pri1
resource "aws_subnet" "Subrede-Pri1" {
  vpc_id            = aws_vpc.VPC-CloudPlay.id
  cidr_block        = "192.168.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subrede-Pri1"
  }
}

# ROUTE TABLE Publica
resource "aws_route_table" "Rotas-CloudPlay-Pub" {
  vpc_id = aws_vpc.VPC-CloudPlay.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW-CloudPlay.id
  }

  tags = {
    Name = "Rotas-CloudPlay-Pub"
  }
}

# ROUTE TABLE Privada
resource "aws_route_table" "Rotas-CloudPlay-Pri" {
  vpc_id = aws_vpc.VPC-CloudPlay.id

  tags = {
    Name = "Rotas-CloudPlay-Pri"
  }
}

# SUBNET ASSOCIATION Pub
resource "aws_route_table_association" "Subrede-Pub" {
  subnet_id      = aws_subnet.Subrede-Pub1.id
  route_table_id = aws_route_table.Rotas-CloudPlay-Pub.id
}