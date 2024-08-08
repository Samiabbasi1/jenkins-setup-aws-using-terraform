output "aws_lb_dns_name" {
  value = aws_lb.vpc_lb.dns_name
}

output "aws_lb_zone_id" {
  value = aws_lb.vpc_lb.zone_id
}