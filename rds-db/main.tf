locals {
  rds_db = {
    for i in var.payload_rds_instance :
    i.name => i
  }
}

resource "aws_db_subnet_group" "this" {
  for_each    = local.rds_db
  name        = "${each.value.name}-subnet-group"
  description = each.value.description
  subnet_ids  = [var.subnet_ids[each.value.subnet_name[0]], var.subnet_ids[each.value.subnet_name[1]]]

  tags = merge(
    {
      "Name" = "${each.value.name}-subnet-group"
    },
    var.tags
  )
}


resource "aws_db_instance" "this" {
  for_each                  = local.rds_db
  identifier                = each.value.name
  engine                    = each.value.engine
  engine_version            = each.value.engine_version
  instance_class            = each.value.instance_class
  allocated_storage         = each.value.allocated_storage
  username                  = each.value.username
  password                  = each.value.password
  skip_final_snapshot       = var.skip_final_snapshot

  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  vpc_security_group_ids              = var.vpc_security_group_ids
  db_subnet_group_name                = aws_db_subnet_group.this[each.value.name].id

  availability_zone       = var.availability_zone
  multi_az                = var.multi_az
  publicly_accessible     = var.publicly_accessible

  tags = merge(
    {
      "Name" = format("%s", each.value.name)
    },
    var.tags
  )
}

  
  