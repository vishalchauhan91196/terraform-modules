### AWS Lambda function ###
# AWS Lambda API requires a ZIP file with the execution code
data "archive_file" "start_scheduler" {
  type        = "zip"
  source_file = "start_ec2_instances.py"
  output_path = "start_ec2_instances.zip"
}

data "archive_file" "stop_scheduler" {
  type        = "zip"
  source_file = "stop_ec2_instances.py"
  output_path = "stop_ec2_instances.zip"
}

# Lambda defined that runs the Python code with the specified IAM role
resource "aws_lambda_function" "ec2_start_scheduler_lambda" {
  filename         = data.archive_file.start_scheduler.output_path
  function_name    = "start_ec2_instances"
  role             = aws_iam_role.ec2_start_stop_scheduler.arn
  handler          = "start_ec2_instances.lambda_handler"
  runtime          = "python3.9"
  timeout          = 300
  source_code_hash = "${data.archive_file.start_scheduler.output_base64sha256}"
}

resource "aws_lambda_function" "ec2_stop_scheduler_lambda" {
  filename         = data.archive_file.stop_scheduler.output_path
  function_name    = "stop_ec2_instances"
  role             = aws_iam_role.ec2_start_stop_scheduler.arn
  handler          = "stop_ec2_instances.lambda_handler"
  runtime          = "python3.9"
  timeout          = 300
  source_code_hash = data.archive_file.stop_scheduler.output_base64sha256
}