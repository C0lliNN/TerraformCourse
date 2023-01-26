variable "security_groups" {
    type = list(string)
    default = []
}

variable "user_data" {
  type = string
  default = ""
}

resource "aws_instance" "instance" {
  ami             = "ami-0b5eea76982371e91"
  instance_type   = "t3.micro"
  security_groups = var.security_groups
  user_data       = var.user_data
}

output "instance_id" {
  value = aws_instance.instance.id
}