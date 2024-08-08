resource "aws_lb_target_group" "lb_tg" {
  name = var.lb_tg_name
  port = var.lb_tg_port
  protocol = var.lb_tg_protocol
  vpc_id = var.vpc_id
  health_check {
    path = "/login"
    port = 8080
    healthy_threshold = 6
    unhealthy_threshold = 2
    timeout = 2
    interval = 5
    matcher = "200"
  }
}

resource "aws_lb_target_group_attachment" "lb_tg_ec2_jenkins" {
  target_group_arn = aws_lb_target_group.lb_tg.arn
  target_id = var.ec2_instance_id
  port = 8080
}