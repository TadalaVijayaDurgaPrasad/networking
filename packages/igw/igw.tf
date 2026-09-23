resource "aws_internet_gateway" "this" {
    for_each = var.igw_details
    vpc_id = each.value.vpc_id
  lifecycle {
    prevent_destroy       = false
    create_before_destroy = false
  }
    tags = merge(var.common_tags, {
        Name = each.value.igw_name
    })
}

output "igw_id" {
  value = {
    for k, v in aws_internet_gateway.this : k => v.id
  }
}