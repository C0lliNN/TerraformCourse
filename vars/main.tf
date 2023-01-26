provider "aws" {
  region = "us-east-1"
  profile = "terraform"
}

variable "number_of_servers" {
  type = number
}

resource "aws_instance" "ec2" {
  ami = "ami-0b5eea76982371e91"
  instance_type = "t3.micro"
  count = var.number_of_servers
}

