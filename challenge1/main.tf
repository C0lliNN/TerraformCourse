provider "aws" {
  region = "us-east-1"
  profile = "terraform"
}

variable "vpcname" {
  type = string
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = var.vpcname
  }
}

output "vpc_arn" {
  value = aws_vpc.myvpc.arn
}