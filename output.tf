output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.subnet.public_subnet_id
}

output "private_subnet_ids" {
  value = module.subnet.private_subnet_ids
}

output "igw_id" {
  value = module.igw.igw_id
}

output "nat_gw_id" {
  value = module.nat_gw.nat_gw_id
}

output "route_table_id" {
  value = module.route_table.route_table_id
}

output "nacl_id" {
  value = module.nacl.nacl_id
}
