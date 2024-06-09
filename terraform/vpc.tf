resource "aws_vpc" "node_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true


  tags = {
    Name = "node-vpc"
  }
}

resource "aws_subnet" "public-sub" {
  vpc_id            = aws_vpc.node_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}