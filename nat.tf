resource "aws_eip" "eip" {
    
}

resource "aws_nat_gateway" "nat" {
  subnet_id = aws_subnet.ins_pub_subnet_1a.id
  allocation_id = aws_eip.eip.id
}

resource "aws_route_table" "nat_rt" {
  vpc_id = aws_vpc.ins_vpc.id
  route {
    nat_gateway_id = aws_nat_gateway.nat.id
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "nat_rta" {
  route_table_id = aws_route_table.nat_rt.id
  subnet_id = aws_subnet.ins_pri_subnet_1a.id
}