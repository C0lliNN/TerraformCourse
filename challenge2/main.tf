provider "aws" {
  region  = "us-east-1"
  profile = "terraform"
}

resource "aws_security_group" "webserver_sg" {
  name = "Allow HTTP and HTTPs traffic"

  ingress {
    description      = "HTTPs Access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP Access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "database_sg" {
  name = "Allow only traffic coming from the Web Server"

  ingress {
    description     = "Webserver MySQL Access"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.webserver_sg.id]
  }
}

resource "aws_instance" "webserver" {
  ami             = "ami-0b5eea76982371e91"
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.webserver_sg.name]
  user_data       = <<EOF
    #!/bin/bash
    sudo yum update
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo "<h1>Hello from Terraform</h1>" | sudo tee /var/www/html/index.html
  EOF
}

resource "aws_eip" "webserver_eip" {
  instance = aws_instance.webserver.id
}

resource "aws_instance" "database" {
  ami             = "ami-0b5eea76982371e91"
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.database_sg.name]
}

output "webserver_public_ip" {
  value = aws_eip.webserver_eip.public_ip
}
