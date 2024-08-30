resource "aws_vpc_peering_connection" "vpc_peer" {
  vpc_id = aws_vpc.ins_vpc.id
  peer_vpc_id = aws_vpc.rds_vpc.id
  auto_accept = true
}

resource "aws_route" "route" {
  route_table_id = aws_route_table.nat_rt.id
  destination_cidr_block = aws_vpc.rds_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}

resource "aws_route" "route_rds" {
  route_table_id = aws_route_table.rda_rt.id
  destination_cidr_block = aws_vpc.ins_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer.id
}
