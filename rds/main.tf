provider "aws" {
  region  = "us-east-1"
  profile = "terraform"
}

resource "aws_db_instance" "my_rds" {
  name                = "my_db"
  identifier          = "my-first-rds"
  instance_class      = "db.t2.micro"
  engine              = "mariadb"
  engine_version      = "10.2.21"
  username            = "collin"
  password            = "password123"
  port                = 3306
  allocated_storage   = 20
  skip_final_snapshot = true
}
