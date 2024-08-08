resource "aws_instance" "jenkins_ec2" {
  ami = var.ami_id
  instance_type = var.instance_type
  tags = {
    name = var.tag_name
  }
  key_name = var.public_key
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.sg_for_jenkins
  associate_public_ip_address = var.enable_public_ip_address
  user_data = var.user_data_install_jenkins
  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }
}

resource "aws_key_pair" "jenkins_ec2_key" {
  key_name = "aws_ec2"
  public_key = var.public_key
}