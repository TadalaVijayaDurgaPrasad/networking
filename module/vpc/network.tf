resource "aws_vpc" "this" {
  count = var.create_vpc ? 1 : 0

  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "this" {
  for_each = var.subnet_details

  vpc_id                  = var.vpc_id != "" ? var.vpc_id : aws_vpc.this[0].id
  cidr_block              = each.value.subnet_cidr
  availability_zone       = each.value.subnet_az
  map_public_ip_on_launch = each.value.subnet_type == "public" ? true : false

  tags = {
    Name = each.value.subnet_name
  }
}
locals {
  public_subnet_id = one([
    for k, v in aws_subnet.this : v.id
    if var.subnet_details[k].subnet_type == "public"
  ])
}
resource "aws_internet_gateway" "this" {
  count = var.create_igw ? 1 : 0

  vpc_id = var.vpc_id != "" ? var.vpc_id : aws_vpc.this[0].id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_eip" "this" {
    for_each = var.nat_gw_details
    domain = "vpc"

  tags = {
    Name =  "${each.value.nat_gw_name}-eip"
  }
}
locals {
  eip_id= one([for k,v in aws_eip.this:v.id
  if var.nat_gw_details[k].require_aws_eip == true])
}

resource "aws_nat_gateway" "this" {
    # count = var.create_nat_gw ? 1 : 0
    for_each = var.nat_gw_details
    allocation_id = each.value.aws_eip_id != "" ? each.value.aws_eip_id : local.eip_id
    subnet_id     = each.value.subnet_id != "" ? each.value.subnet_id : local.public_subnet_id
    tags = {
        Name = each.value.nat_gw_name
    }
}

locals {
  nat_gateway_id=one([
    for k,v in aws_nat_gateway.this:v.id
    if var.nat_gw_details[k].nat_gw_name != ""
  ])
  igw_id=one([
    for k,v in aws_internet_gateway.this:v.id
    if var.igw_name != ""
  ])
}
resource "aws_route_table" "this" {
    for_each =  var.route_table_details
    vpc_id = var.vpc_id !=""? var.vpc_id : aws_vpc.this[0].id
    route {
        cidr_block = var.common_address
        gateway_id = each.value.nat_required ? (
            each.value.nat_gw_id !="" ? each.value.nat_gw_id : local.nat_gateway_id) : (
                each.value.igw_required ? local.igw_id : null)
    }
    tags = {
        Name = each.value.route_table_name
    }
}

resource "aws_route_table_association" "this" {
    for_each = var.subnet_details
    subnet_id      = aws_subnet.this[each.key].id
    route_table_id = var.route_table_details[each.key].route_table_name != "" ? aws_route_table.this[each.key].id : null
}
