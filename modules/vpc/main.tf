resource "aws_vpc" "new-infra" {
  cidr_block = var.cidr_block
  instance_tenancy = var.instance_tenancy
  enable_dns_hostnames = true
  enable_dns_support = true
  region = var.region

  tags = {
    Name = "new-infra"
  }
}

resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.new-infra.id
    availability_zone =  var.availability_zone
    cidr_block = var.subnet1cidr_block
    map_public_ip_on_launch = var.subnet1publicip

    tags = {
      Name = var.subnet_name
    }
}

resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.new-infra.id
    availability_zone =  var.availability_zone2
    cidr_block = var.subnet2cidr_block

    tags = {
      Name = var.subnet_name2
    }
}

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.new-infra.id

  tags = {
    Name = "internet-gateway"
  }
}

resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.new-infra.id

    route {
    cidr_block = var.routetablecidr
    gateway_id = aws_internet_gateway.internet-gateway.id    
   }
   tags = {
    Name = "route_table"
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id = aws_vpc.new-infra.id
  service_name = var.service_name
  vpc_endpoint_type = var.type
  route_table_ids = [aws_vpc.new-infra.main_route_table_id]

  tags = {
    Name = "s3-endpoint"
  }
}



