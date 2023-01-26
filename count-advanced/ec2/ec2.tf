variable "ec2names" {
  type = list(string)
}

resource "aws_instance" "ec2" {
  ami = "ami-0b5eea76982371e91"
  instance_type = "t3.micro"
  tags = {
    Name = var.ec2names[count.index]
  }
  count = length(var.ec2names)
}

output "instance_id" {
  value = [aws_instance.ec2.*.id]
}
