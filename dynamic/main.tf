provider "aws" {
  region = "us-east-1"
  profile = "terraform"
}

variable "ingressrules" {
    type = list(number)
    default = [ 80, 443 ]
}

variable "egressrules" {
    type = list(number)
    default = [80, 443, 25, 3306, 53, 8080]
}

resource "aws_instance" "ec2" {
  ami = "ami-0b5eea76982371e91"
  instance_type = "t3.micro"
  security_groups = [aws_security_group.webtraffic.name]
}

resource "aws_security_group" "webtraffic" {
  name = "Allow HTTPS"

  dynamic ingress {
    iterator = port
    for_each = var.ingressrules
    content {      
        description      = "TLS from VPC"
        from_port        = port.value
        to_port          = port.value
        protocol         = "tcp"
    }
  }

  dynamic egress {
    iterator = port
    for_each = var.egressrules
    content {
        from_port        = port.value
        to_port          = port.value
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
  }
}