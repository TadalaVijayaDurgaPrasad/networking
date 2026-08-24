resource "aws_subnet" "this" {
    for_each = var.subnet_details
    vpc_id = each.value.vpc_id
    cidr_block = each.value.subnet_cidr
    availability_zone = each.value.subnet_az
    map_public_ip_on_launch = each.value.subnet_type == "public" ? true : false
    tags = {
        Name = each.value.subnet_name
    }
}

output "public_subnet_id" {
  value = one([
    for k, v in aws_subnet.this : v.id
    if var.subnet_details[k].subnet_type == "public"
  ])
}

output "private_subnet_ids" {
  value = {
    for k, v in aws_subnet.this : k => v.id
    if var.subnet_details[k].subnet_type == "private"
  }
}