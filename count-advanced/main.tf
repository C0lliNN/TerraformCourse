provider "aws" {
  region = "us-east-1"
  profile = "terraform"
}

module "servers" {
  source = "./ec2"
  ec2names = ["Web", "Database"]
}

output "ids" {
  value = module.servers.instance_id
}