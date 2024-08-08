module "networking" {
  source                = "../modules/networking"
  vpc_name              = var.vpc_name
  vpc_cidr              = var.vpc_cidr
  cidr_public           = var.cidr_public
  cidr_private          = var.cidr_private
  us_availability_zones = var.us_availibility_zone
}

module "Sg" {
  source         = "../modules/sg"
  vpc_id         = module.networking.vpc_id
  ec2_sg         = "sg for 22,80 and 443"
  ec2_jenkins_sg = "sg for 8080"
}

module "jenkins" {
  source                    = "../modules/jenkins"
  ami_id                    = var.ec2_ami
  instance_type             = "t2.medium"
  tag_name                  = "Jenkins:Ubuntu Linux EC2"
  public_key                = var.pub_key
  subnet_id                 = tolist(module.networking.public_subnets)[0]
  sg_for_jenkins            = [module.Sg.sg_ec2_sg_ssh_http_id, module.Sg.sg_ec2_jenkins_port_8080]
  enable_public_ip_address  = true
  user_data_install_jenkins = templatefile("../modules/j-script/script.sh", {})
}

module "lb_target_group" {
  source          = "../modules/lb-tg"
  vpc_id          = module.networking.vpc_id
  lb_tg_name      = "tgforjenkins"
  lb_tg_port      = 8080
  lb_tg_protocol  = "HTTP"
  ec2_instance_id = module.jenkins.vpc_ec2_instance_public_ip
}

module "alb" {
  source                    = "../modules/lb"
  lb_name                   = "vpclb"
  is_external               = false
  lb_type                   = "application"
  subnet_ids                = tolist(module.networking.public_subnets)
  tag_name                  = "vpc-alb"
  lb_tg_arn                 = module.lb_target_group.lb_target_group_arn
  ec2_instance_id           = module.jenkins.jenkins_ec2_ip
  lb_listner_port           = 80
  lb_listner_protocol       = "HTTP"
  lb_listner_default_action = "forward"
  lb_https_listner_port     = 443
  lb_https_listner_protocol = "HTTPS"
  vpc_acm_arn               = module.acm.vpc_acm_arn
  lb_tg_attachment_port     = 8080
  sg_https                  = module.Sg.sg_ec2_sg_ssh_http_id
}

module "hostedzone" {
  source          = "../modules/hosted-zone"
  domain_name     = "   cloudwithsami.free.nf"
  aws_lb_dns_name = module.alb.aws_lb_dns_name
  aws_lb_zone_id  = module.alb.aws_lb_zone_id
}

module "acm" {
  source         = "../modules/cfm"
  domain_name    = "cloudwithsami.free.nf"
  hosted_zone_id = module.hostedzone.hosted_zone_id
}