# provider "aws" {
#   region = "us-east-1"
# }

# module "VPC" {
#     source = "./module/vpc"
#     create_vpc = true
#     create_igw = true
#     create_nat_gw = true
#     create_route_table = true
#     create_eip = true
#     create_subnet = true

#     vpc_name = "demo-vpc"
#     vpc_cidr = "10.0.0.0/16"
#     subnet_details ={
#         public = {
#             subnet_az = "us-east-1a"
#             subnet_cidr = "10.0.1.0/24"
#             subnet_name = "dev-pub-subnet"
#             subnet_type = "public"
#         }
#         private = {
#             subnet_az = "us-east-1a"
#             subnet_cidr = "10.0.2.0/24"
#             subnet_name = "dev-private-subnet"
#             subnet_type = "private"
#         }
#     }
#     igw_name = "demo-igw"
#     nat_gw_details = {
#         nat1 = {
#             nat_gw_name = "demo-nat-gw"
#             require_aws_eip = true
#             aws_eip_id = ""
#             subnet_id = ""
#         }
      
#     }
#     route_table_details = {
#         public = {
#             route_table_name = "demo-public-route-table"
#             igw_id = ""
#             igw_required = true
#             nat_gw_id = ""
#             nat_required = false
#         }
#         private = {
#             route_table_name = "demo-private-route-table"
#             igw_id = ""
#             igw_required = false
#             nat_gw_id = ""
#             nat_required = true
#         }
#     }
  
# }


provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source   = "./packages/vpc"
  vpc_name = "demo-vpc"
  vpc_cidr = "10.0.0.0/16"
}

module "subnet" {
  source = "./packages/subnet"

  subnet_details = {
    public = {
      vpc_id       = module.vpc.vpc_id
      subnet_az    = "us-east-1a"
      subnet_cidr  = "10.0.1.0/24"
      subnet_name  = "dev-pub-subnet"
      subnet_type  = "public"
    }
    privateA = {
      vpc_id      = module.vpc.vpc_id
      subnet_az   = "us-east-1a"
      subnet_cidr = "10.0.2.0/24"
      subnet_name = "dev-private-subnet-a"
      subnet_type = "private"
    }
    privateB = {
      vpc_id      = module.vpc.vpc_id
      subnet_az   = "us-east-1b"
      subnet_cidr = "10.0.3.0/24"
      subnet_name = "dev-private-subnet-b"
      subnet_type = "private"
    }
  }
}

module "igw" {
  source = "./packages/igw"

  igw_details = {
    igw1 = {
      vpc_id   = module.vpc.vpc_id
      igw_name = "demo-igw"
    }
  }
}

module "nat_gw" {
  source = "./packages/nat_gw"

  nat_gw_details = {
    nat1 = {
      nat_gw_name  = "demo-nat-gw"
      required_eip = true
      aws_eip_id   = ""
      subnet_id    = module.subnet.public_subnet_id
    }
  }
}

module "route_table" {
  source = "./packages/route_table"

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

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = module.subnet.public_subnet_id
  route_table_id = module.route_table.route_table_id["public"]
}

resource "aws_route_table_association" "private_assoc" {
  for_each = module.subnet.private_subnet_ids

  subnet_id      = each.value
  route_table_id = module.route_table.route_table_id["privateA"]
}