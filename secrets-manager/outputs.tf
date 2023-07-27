output "arn" {
  description = "ARN of AWS Secrets Manager"
  value = {
    for aws_secretsmanager_secret in aws_secretsmanager_secret.this :
    aws_secretsmanager_secret.name => aws_secretsmanager_secret.arn
  }
}