resource "aws_lb" "vpc_lb" {
  name = var.lb_name
  internal = var.is_external
  load_balancer_type = var.lb_type
  security_groups = [var.sg_https]
  subnets = var.subnet_ids
  enable_deletion_protection = false
  tags = {
    name = "vpc_lb"
  }
}

resource "aws_lb_target_group_attachment" "vpc_lb_tg_attatchment" {
  target_group_arn = var.lb_tg_arn
  target_id = var.ec2_instance_id
  port = var.lb_https_listner_port
}

resource "aws_lb_listener" "vpc_lb_listener" {
  load_balancer_arn = aws_lb.vpc_lb.arn
  port = var.lb_listner_port
  protocol = var.lb_listner_protocol
  default_action {
    type = var.lb_listner_default_action
    target_group_arn = var.lb_tg_arn
  }
}

resource "aws_lb_listener" "dev_proj_1_lb_https_listner" {
  load_balancer_arn = aws_lb.vpc_lb.arn
  port              = var.lb_https_listner_port
  protocol          = var.lb_https_listner_protocol
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn   = var.vpc_acm_arn

  default_action {
    type             = var.lb_listner_default_action
    target_group_arn = var.lb_tg_arn
  }
}