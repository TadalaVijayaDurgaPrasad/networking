region = "eu-central-1"
environment = "dev"
vpc_cidr = "10.0.0.0/16"
prevent_destroy = false
create_before_destroy = false
subnet_details = {
  public = {
    subnet_az   = "eu-central-1a"
    subnet_cidr = "10.0.1.0/24"
    subnet_name = "pub-subnet"
    subnet_type = "public"
  }
  privateA = {
    subnet_az   = "eu-central-1a"
    subnet_cidr = "10.0.2.0/24"
    subnet_name = "priv-subnet-a"
    subnet_type = "private"
  }
  privateB = {
    subnet_az   = "eu-central-1b"
    subnet_cidr = "10.0.3.0/24"
    subnet_name = "priv-subnet-b"
    subnet_type = "private"
  }
}

igw_details = {
  igw1 = {
      igw_name = "demo-igw"
    }
}

nat_gw_details = {
    nat1 = {
      nat_gw_name  = "demo-nat-gw"
      required_eip = true
      aws_eip_id   = ""
    }
}