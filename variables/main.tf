provider "aws" {
  region = "us-east-1"
  profile = "terraform"
}

variable "vpc_name" {
  type = string
  default = "myvpc"
}

variable "ssh_port" {
  type = number
  default = 22
}

variable "enabled" {
  default = true
}

variable "mylist" {
  type = list(string)
  default = [ "value1", "value2" ]
}

variable "mymap" {
  type = map
  default = {
    Key1 = "Value1"
    Key2 = 50
  }
}

variable "input_name" {
    type = string
    description = "Set the name of the VPC"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    # same with numbers and booleans
    Name = var.vpc_name
    Tag2 = var.mylist[0]
    Tag3 = var.mymap["Key1"]
    Tag4 = var.input_name
  }
}

output "vpcid" {
  value = aws_vpc.myvpc.id
}

variable "mytuple" {
  type = tuple([string, number, string])
  default = ["cat", 1, "dogs"]
}

variable "myobject" {
    type = object({name = string, port = number})
    default = {
      name = "myvpc"
      port = 22
    }
}