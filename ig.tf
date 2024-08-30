resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.ins_vpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.ins_vpc.id
  route {
    gateway_id = aws_internet_gateway.ig.id
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "rta_1a" {
  route_table_id = aws_route_table.rt.id
  subnet_id = aws_subnet.ins_pub_subnet_1a.id
}

resource "aws_route_table_association" "rta_1b" {
  route_table_id = aws_route_table.rt.id
  subnet_id = aws_subnet.ins_pub_subnet_1b.id
}