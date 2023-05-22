### IAM Role and Policy ###
# Allows Lambda function to describe, stop and start EC2 instances
resource "aws_iam_role" "ec2_start_stop_scheduler" {
  name = "ec2-start-stop-lambda-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

#Create an IAM policy document
data "aws_iam_policy_document" "ec2_start_stop_scheduler" {
  statement {
    actions = [
      "logs:*"
    ]
    resources = ["*"]
    effect = "Allow"
  }

  statement {
    actions = [
      "ec2:*"
    ]
    resources = ["*"]
    effect = "Allow"
  }
}

# Attach the IAM policy document to IAM policy
resource "aws_iam_policy" "ec2_start_stop_scheduler" {
  name = "ec2-start-stop-lambda-policy"
  path = "/"
  policy = data.aws_iam_policy_document.ec2_start_stop_scheduler.json
}

# Attach the IAM policy to IAM role
resource "aws_iam_role_policy_attachment" "ec2_access_scheduler" {
  role       = aws_iam_role.ec2_start_stop_scheduler.name
  policy_arn = aws_iam_policy.ec2_start_stop_scheduler.arn
}