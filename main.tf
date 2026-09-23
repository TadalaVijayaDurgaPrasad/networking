provider "aws" {
  region = var.region
}

module "vpc" {
  source      = "./packages/vpc"
  vpc_cidr    = var.vpc_cidr
  common_tags = local.common_tags
  region      = var.region
  region_code = local.region_code
  environment  = var.environment
  prevent_destroy       = var.prevent_destroy
  create_before_destroy = var.create_before_destroy
}

module "subnet" {
  source = "./packages/subnet"

  common_tags = local.common_tags
  depends_on  = [module.vpc]
  region      = var.region
  region_code = local.region_code
  environment  = var.environment
  prevent_destroy       = var.prevent_destroy
  create_before_destroy = var.create_before_destroy
  subnet_details = {
    for k, v in var.subnet_details : k => {
      vpc_id      = module.vpc.vpc_id
      subnet_az   = v.subnet_az
      subnet_cidr = v.subnet_cidr
      subnet_name = v.subnet_name
      subnet_type = v.subnet_type
    }
  }
}

module "igw" {
  source = "./packages/igw"

  common_tags     = local.common_tags
  depends_on      = [module.subnet]

  igw_details = {
    for k, v in var.igw_details : k => {
      igw_name = v.igw_name
      vpc_id   = module.vpc.vpc_id
    }
  }
}

module "nat_gw" {
  source = "./packages/nat_gw"

  common_tags     = local.common_tags
  depends_on      = [module.subnet]

  nat_gw_details = {
    for k, v in var.nat_gw_details : k => {
      nat_gw_name     = v.nat_gw_name
      required_eip    = v.required_eip
      aws_eip_id      = v.aws_eip_id
      subnet_id       = module.subnet.public_subnet_id
    }
  }
}

module "route_table" {
  source = "./packages/route_table"

  common_tags     = local.common_tags
  depends_on      = [module.igw, module.nat_gw]
  route_table_details = {
    public = {
      vpc_id     = module.vpc.vpc_id
      route_cidr = "0.0.0.0/0"
      gateway_id = module.igw.igw_id["igw1"]
    }
    privateA = {
      vpc_id     = module.vpc.vpc_id
      route_cidr = "0.0.0.0/0"
      gateway_id = module.nat_gw.nat_gw_id["nat1"]
    }
  }
}

module "nacl" {
  source = "./packages/nacl"

  common_tags     = local.common_tags
  depends_on      = [module.subnet]
  network_acl_details = {
    nacl1 = {
      vpc_id           = module.vpc.vpc_id
      network_acl_name = "test-nacl"
      subnets          = values(module.subnet.private_subnet_ids)
      egress_rules = {
        egrule1 = {
          rule_no    = 100
          protocol   = "tcp"
          action     = "allow"
          cidr_block = "10.0.1.0/24"
          from_port  = 443
          to_port    = 443
        }
      }
      ingress_rules = {
        ingrule1 = {
          rule_no    = 100
          protocol   = "tcp"
          action     = "allow"
          cidr_block = "10.0.1.0/24"
          from_port  = 443
          to_port    = 443
        }
      }
    }
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = module.subnet.public_subnet_id
  route_table_id = module.route_table.route_table_id["public"]
}

resource "aws_route_table_association" "private_assoc" {
  for_each = module.subnet.private_subnet_ids

  subnet_id      = each.value
  route_table_id = module.route_table.route_table_id["privateA"]
}
