variable "payload_fsx" {}

variable "subnet_ids" {}

variable "aws_directory_service_directory" {}

variable "security_group_ids" {}

variable "tags" {
  description = "A map of tags to add to all resources. Tags added to launch configuration or templates override these values for EFS Tags only."
  type        = map(string)
  default     = {}
}