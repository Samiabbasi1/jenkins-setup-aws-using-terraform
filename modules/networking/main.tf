resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  count = length(var.cidr_public)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.cidr_public,count.index)
  availability_zone = element(var.us_availability_zones,count.index)
  tags = {
    name = "public-subnets-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count = length(var.cidr_private)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.cidr_private,count.index)
  availability_zone = element(var.us_availability_zones,count.index)
  tags = {
    name = "private-subnets-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    name = "igw for vpc"
  }
}

resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }
  tags = {
    name = "rt for public subnets"
  }
}

resource "aws_route_table_association" "pub-rt-assoc" {
  count = length(aws_subnet.public_subnet)
  subnet_id = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.pub_rt.id
}
resource "aws_route_table" "prt-rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    name = "rt for private subnets"
  }
}
resource "aws_route_table_association" "pri-rt-assoc" {
  count = length(aws_subnet.private_subnet)
  subnet_id = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.prt-rt.id
}