resource "aws_lb" "lb" {
  internal = false
  load_balancer_type = "application"
  subnets = [ aws_subnet.ins_pub_subnet_1a.id, aws_subnet.ins_pub_subnet_1b.id ]
  security_groups = [ aws_security_group.lb_sg.id ]
}

resource "aws_lb_listener" "listener" {
  port = 80
  protocol = "HTTP"
  load_balancer_arn = aws_lb.lb.arn
  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type = "forward"
  }
}