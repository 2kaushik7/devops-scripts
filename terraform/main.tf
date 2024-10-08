provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "qod" {
  ami           = "ami-0df2a11dd1fe1f8e3"
  instance_type = "t2.micro"

  tags = {
    name = "terraform-ec2"
  }

  key_name = "nexus-key"


}

resource "aws_security_group" "ec2-sg" {
  name = "allow_ssh"
  description = "allow SSH inbound traffic"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

