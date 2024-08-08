resource "aws_security_group" "ec2_sg" {
  name        = var.ec2_sg
  description = "enable port 22 and 80"
  vpc_id      = var.vpc_id

  ingress {
    description = "remote access from everywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  ingress {
    description = "allow http"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    description = "allow https"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  egress {
    description = "allow all outgoing"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Sg for 80 and 22."
  }
}

resource "aws_security_group" "ec2_jenkins" {
  name        = var.ec2_jenkins_sg
  description = "enable 8080 for jenkins"
  vpc_id      = var.vpc_id

  ingress {
    description = "allow 8080 port for jenkins"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
  }

  tags = {
    Name = "Sg for 8080"
  }
}