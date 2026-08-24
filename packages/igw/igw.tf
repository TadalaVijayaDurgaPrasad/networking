resource "aws_internet_gateway" "this" {
    for_each = var.igw_details
    vpc_id = each.value.vpc_id
    tags = {
        Name = each.value.igw_name
    }
}

output "igw_id" {
  value = {
    for k, v in aws_internet_gateway.this : k => v.id
  }
}