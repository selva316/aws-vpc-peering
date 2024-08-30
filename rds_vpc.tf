resource "aws_vpc" "rds_vpc" {
  cidr_block = "212.0.0.0/16"
}

resource "aws_subnet" "rds_subnet_1a" {
  cidr_block = "212.0.1.0/24"
  vpc_id = aws_vpc.rds_vpc.id
  map_public_ip_on_launch = false
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "rds_subnet_1b" {
  cidr_block = "212.0.2.0/24"
  vpc_id = aws_vpc.rds_vpc.id
  map_public_ip_on_launch = false
  availability_zone = "ap-south-1b"
}

resource "aws_db_subnet_group" "rds_subg" {
  name = "mysqldb"
  subnet_ids = [ aws_subnet.rds_subnet_1a.id, aws_subnet.rds_subnet_1b.id ]
}
resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.rds_vpc.id
  ingress {
    protocol = "tcp"
    from_port = "3306"
    to_port = "3306"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_route_table" "rda_rt" {
  vpc_id = aws_vpc.rds_vpc.id
}

resource "aws_route_table_association" "rds_rta_1a" {
  subnet_id = aws_subnet.rds_subnet_1a.id
  route_table_id = aws_route_table.rda_rt.id
}

resource "aws_route_table_association" "rds_rta_1b" {
  subnet_id = aws_subnet.rds_subnet_1b.id
  route_table_id = aws_route_table.rda_rt.id
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "root"
  password             = "root123456"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  vpc_security_group_ids = [ aws_security_group.rds_sg.id ]
  db_subnet_group_name = aws_db_subnet_group.rds_subg.id
  storage_type = "gp2"
  publicly_accessible = false
}

output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}