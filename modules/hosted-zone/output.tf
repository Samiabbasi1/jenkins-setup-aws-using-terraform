output "hosted_zone_id" {
  value = data.aws_route53_zone.vpc_cloudwithsami.zone_id
}