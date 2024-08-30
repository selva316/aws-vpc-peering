resource "aws_instance" "instance" {
  ami = "ami-0522ab6e1ddcc7055"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.ins_pri_subnet_1a.id
  security_groups = [ aws_security_group.ins_sg.id ]
  user_data = data.template_file.user_data.rendered
  key_name = "aws-learning"
  depends_on = [
    aws_nat_gateway.nat,
    aws_route_table_association.nat_rta,
    aws_db_instance.default
  ]
}

resource "aws_instance" "bastian" {
  ami = "ami-0522ab6e1ddcc7055"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.ins_pub_subnet_1a.id
  security_groups = [ aws_security_group.ins_sg.id ]
  associate_public_ip_address = true
  key_name = "aws-learning"
}