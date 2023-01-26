provider "aws" {
  region  = "us-east-1"
  profile = "terraform"
}

resource "aws_iam_user" "myuser" {
  name = "Collin"
}

resource "aws_iam_policy" "myuser_policy" {
  name = "CollinPolicy"

  policy = <<EOF
{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "Stmt1674757159620",
                "Action": [
                    "ec2:DescribeInstances"
                ],
                "Effect": "Allow",
                "Resource": "*"
            }
        ]
    }
  EOF
}

resource "aws_iam_policy_attachment" "myuser_policy_bind" {
  name       = "Attachment"
  users      = [aws_iam_user.myuser.name]
  policy_arn = aws_iam_policy.myuser_policy.arn
}
