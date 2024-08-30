resource "aws_lb_target_group" "tg" {
  port = 8080
  protocol = "HTTP"
  vpc_id = aws_vpc.ins_vpc.id
}

resource "aws_lb_target_group_attachment" "tga" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = aws_instance.instance.id
  port = 8080
}