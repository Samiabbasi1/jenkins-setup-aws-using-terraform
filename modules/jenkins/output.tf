output "ssh_ec2" {
  value = format("%s%s", "ssh -i /home/abdul-sami/.ssh/aws_ec2_terraform ubuntu@", aws_instance.jenkins_ec2.public_ip)
}

output "jenkins_ec2_ip" {
  value = aws_instance.jenkins_ec2.id
}

output "vpc_ec2_instance_public_ip" {
  value = aws_instance.jenkins_ec2.public_ip
}