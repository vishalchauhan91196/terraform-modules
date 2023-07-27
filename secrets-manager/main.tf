locals {
  secrets_manager = {
    for i in var.payload_secrets_manager :
    i.name => i
  }
}

resource "aws_secretsmanager_secret" "this" {
  for_each    = local.secrets_manager
  name        = each.value.name
  description = each.value.description

  tags = merge(
    {
      "Name" = format("%s", each.value.name)
    },
    var.tags,
  )
}


resource "aws_secretsmanager_secret_version" "this" {
  for_each      = local.secrets_manager
  secret_id     = aws_secretsmanager_secret.this[each.key].id

  secret_string = jsonencode({
    username              = each.value.rds_username
    password              = each.value.rds_password
    engine                = var.rds_engine[each.value.rds_name]
    host                  = var.rds_address[each.value.rds_name]
    port                  = "3306"
    dbInstanceIdentifier  = var.rds_dbInstanceIdentifier[each.value.rds_name]
  })
}