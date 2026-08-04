provider "aws" {
  region = "us-east-1"
}

module "VPC" {
    source = "./module/vpc"
    create_vpc = true
    create_igw = true
    create_nat_gw = true
    create_route_table = true
    create_eip = true
    create_subnet = true

    vpc_name = "demo-vpc"
    vpc_cidr = "10.0.0.0/16"
    subnet_details ={
        public = {
            subnet_az = "us-east-1a"
            subnet_cidr = "10.0.1.0/24"
            subnet_name = "dev-pub-subnet"
            subnet_type = "public"
        }
        private = {
            subnet_az = "us-east-1a"
            subnet_cidr = "10.0.2.0/24"
            subnet_name = "dev-private-subnet"
            subnet_type = "private"
        }
    }
    igw_name = "demo-igw"
    nat_gw_details = {
        nat1 = {
            nat_gw_name = "demo-nat-gw"
            require_aws_eip = true
            aws_eip_id = ""
            subnet_id = ""
        }
      
    }
    route_table_details = {
        public = {
            route_table_name = "demo-public-route-table"
            igw_id = ""
            igw_required = true
            nat_gw_id = ""
            nat_required = false
        }
        private = {
            route_table_name = "demo-private-route-table"
            igw_id = ""
            igw_required = false
            nat_gw_id = ""
            nat_required = true
        }
    }
  
}
