provider "aws" {
  region = "us-east-1"
  profile = "terraform"
}

module "ec2module" {
  source = "./ec2"
  ec2name = "Web Server"
}

output "module_output" {
  value = module.ec2module.instance_id
}
