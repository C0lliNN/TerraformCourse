provider "aws" {
  region = "us-east-1"
  profile = "terraform"
}

resource "aws_instance" "ec2" {
  ami = "ami-0b5eea76982371e91"
  instance_type = "t3.micro"
}

resource "aws_eip" "instanceeip" {
  instance = aws_instance.ec2.id
}

output "EIP" {
  value = aws_eip.instanceeip.public_ip
}