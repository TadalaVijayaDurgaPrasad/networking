variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
}

variable "subnet_details" {
  description = "Details of the subnets"
#   type=list(string)
  type = map(object({
    subnet_az   = string
    subnet_cidr = string
    subnet_name = string
    subnet_type = string
  }))
}

variable "igw_details" {
  description = "Details of the Internet Gateways"
  type = map(object({
    igw_name = string
  }))
}

variable "nat_gw_details" {
  description = "Details of the NAT Gateways"
  type = map(object({
    nat_gw_name     = string
    required_eip    = bool
    aws_eip_id      = string
  }))
}