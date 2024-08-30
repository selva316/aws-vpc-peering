resource "aws_vpc" "ins_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "ins_pub_subnet_1a" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.ins_vpc.id
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "ins_pub_subnet_1b" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.ins_vpc.id
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "ins_pri_subnet_1a" {
  cidr_block = "10.0.3.0/24"
  vpc_id = aws_vpc.ins_vpc.id
  map_public_ip_on_launch = false
  availability_zone = "ap-south-1a"
}
