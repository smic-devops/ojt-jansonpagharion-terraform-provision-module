data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpc_main" {
    cidr_block = var.cidr_block_main
    tags = {
        Name = "vpc_main"
    }
}

# ALB subnets
resource "aws_subnet" "public1" {
    vpc_id            = aws_vpc.vpc_main.id
    cidr_block        = "10.0.1.0/24"
    availability_zone = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true
    tags = {
        Name = "public1"
    }
}

resource "aws_subnet" "public2" {
    vpc_id            = aws_vpc.vpc_main.id
    cidr_block        = "10.0.2.0/24"
    availability_zone = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = true
    tags = {
        Name = "public2"
    }
}

# EC2 Subnet
resource "aws_subnet" "private1" {
    vpc_id            = aws_vpc.vpc_main.id
    cidr_block        = "10.0.3.0/24"
    availability_zone = data.aws_availability_zones.available.names[0]
    tags = {
        Name = "private1"
    }
}

### Route Table for Public Subnets & Internet Gateway

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc_main.id
    tags = {
        Name = "igw"
    }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc_main.id
    tags = {
        Name = "public_rt"
    }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rt.id
}

### Route table for Private Subnets

resource "aws_route" "private_rt" {
  route_table_id = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gw.id
}
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.vpc_main.id
    tags = {
        Name = "private_rt"
    }
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags   = { Name = "nat-eip" }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public1.id
  tags          = { Name = "nat-gw" }
}

