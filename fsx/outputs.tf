output "fsx_id" {
  description = "The id of the fsx filesystem."
  value = {
    for fsx in aws_fsx_windows_file_system.this :
    fsx.tags.Name => fsx.id
  }
}

output "fsx_arn" {
  description = "The ARN of the fsx filesystem."
  value = {
    for fsx in aws_fsx_windows_file_system.this :
    fsx.tags.Name => fsx.arn
  }
}

output "fsx_dns_name" {
  description = "The DNS for fsx filesystem."
  value = {
    for fsx in aws_fsx_windows_file_system.this :
    fsx.tags.Name => fsx.dns_name
  }
}