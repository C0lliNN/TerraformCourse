terraform {
  backend "s3" {
    key = "terraform/tfstate.tfsate"
    region = "us-east-1"
    bucket = "collin-bucket"
    access_key = "something"
    secret_key = "something"
  }
}