resource "aws_eip" "this" {
    for_each = {
        for k, v in var.nat_gw_details : k => v
        if try(v.required_eip, false) || try(v.require_aws_eip, false)
    }

    domain = "vpc"
    tags = {
        Name = "${each.value.nat_gw_name}-eip"
    }
}

resource "aws_nat_gateway" "this" {
    for_each = {
        for k, v in var.nat_gw_details : k => v
        if v.aws_eip_id != "" || try(v.required_eip, false) || try(v.require_aws_eip, false)
    }

    allocation_id = each.value.aws_eip_id != "" ? each.value.aws_eip_id : aws_eip.this[each.key].id
    subnet_id     = each.value.subnet_id
    tags = {
        Name = each.value.nat_gw_name
    }
}

output "nat_gw_id" {
  value = {
    for k, v in aws_nat_gateway.this : k => v.id
  }
}