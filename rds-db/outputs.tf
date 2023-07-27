output "db_instance_id" {
  description = "ID of RDS Instance"
  value = {
    for rds_id in aws_db_instance.this :
    rds_id.tags.Name => rds_id.id
  }
}

output "db_instance_engine" {
  description = "ID of RDS Instance"
  value = {
    for rds_id in aws_db_instance.this :
    rds_id.tags.Name => rds_id.engine
  }
}

output "db_instance_address" {
  description = "ID of RDS Instance"
  value = {
    for rds_id in aws_db_instance.this :
    rds_id.tags.Name => rds_id.address
  }
}