# Internet VPC
resource "aws_vpc" "glofox" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "glofox"
  }
}

# Subnets
resource "aws_subnet" "glofox-public-1a" {
  vpc_id                  = "${aws_vpc.glofox.id}"
  availability_zone       = "eu-west-1a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags {
    Name = "glofox-public-1a"
  }
}

resource "aws_subnet" "glofox-public-1b" {
  vpc_id                  = "${aws_vpc.glofox.id}"
  availability_zone       = "eu-west-1b"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"

  tags {
    Name = "glofox-public-1b"
  }
}

# Internet GW
resource "aws_internet_gateway" "glofox-igw" {
  vpc_id = "${aws_vpc.glofox.id}"

  tags {
    Name = "glofox"
  }
}

# route tables
resource "aws_route_table" "glofox-public" {
  vpc_id = "${aws_vpc.glofox.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.glofox-igw.id}"
  }

  tags {
    Name = "glofox-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "glofox-public-1-a" {
  subnet_id      = "${aws_subnet.glofox-public-1a.id}"
  route_table_id = "${aws_route_table.glofox-public.id}"
}

resource "aws_route_table_association" "glofox-public-2-a" {
  subnet_id      = "${aws_subnet.glofox-public-1b.id}"
  route_table_id = "${aws_route_table.glofox-public.id}"
}
