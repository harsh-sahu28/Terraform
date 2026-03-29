# Region

provider "aws" {

  region = "us-west-2"

}

# Key value pair

resource "aws_key_pair" "my_key_pair" {

  key_name   = "terraform-auto-key"
  public_key = file("terraform-key.pub")

}

# Default PVC

resource "aws_default_vpc" "default" {

}

# Resource

resource "aws_security_group" "my_security_group" {

  name        = "terra-security-group"
  vpc_id      = aws_default_vpc.default.id # inetrpollation - import other resource value to here
  description = "this is inbound and outbound rules for the intance security group"

}

# Inbound and Outbound port rules

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# EC2 instance

resource "aws_instance" "my_instance" {

  count = 3
  ami   = "ami-0d76b909de1a0595d" #AMI id

  instance_type = "t3.micro"

  key_name = aws_key_pair.my_key_pair.key_name

  vpc_security_group_ids = [aws_security_group.my_security_group.id] #VPC and security Group

  # root storage (EBS)
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }
  tags = {
    Name = "terra-automate-server"
  }

}
