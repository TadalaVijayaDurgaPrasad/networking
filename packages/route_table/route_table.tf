resource "aws_route_table" "this" {
    for_each = var.route_table_details
    vpc_id = each.value.vpc_id
    route {
        cidr_block = each.value.route_cidr
        gateway_id = each.value.gateway_id
    }
    tags = {
        Name = each.key
    }
}

output "route_table_id" {
  value = {
    for k, v in aws_route_table.this : k => v.id
  }
}