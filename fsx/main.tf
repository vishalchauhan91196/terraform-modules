locals {
  fsx = {
    for i in var.payload_fsx :
    i.name => i
  }
}

resource "aws_fsx_windows_file_system" "this" {
  for_each            = local.fsx
  active_directory_id = var.aws_directory_service_directory[each.value.active_directory_name]
  storage_capacity    = each.value.storage_capacity
  deployment_type     = each.value.deployment_type
  subnet_ids          = [var.subnet_ids[each.value.subnet_name[0]],var.subnet_ids[each.value.subnet_name[1]]]
  preferred_subnet_id = var.subnet_ids[each.value.subnet_name[0]]
  security_group_ids  = var.security_group_ids
  throughput_capacity = each.value.throughput_capacity

  tags = merge(
    {
      "Name" = format("%s", each.value.name)
    },
    var.tags,
  )
}