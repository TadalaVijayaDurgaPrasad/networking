# confirm whether to create resource or not
variable "create_vpc" {
  description = "Flag to create VPC"
  type        = bool
}
variable "create_subnet" {
  description = "Flag to create subnet"
  type        = bool
}
variable "create_igw" {
  description = "Flag to create Internet Gateway"
  type        = bool
}
variable "create_eip" {
    description = "Flag to create EIP"
    type        = bool
}
variable "create_nat_gw" {
  description = "Flag to create NAT Gateway"
  type        = bool
}
variable "create_route_table" {
  description = "Flag to create route table"
  type        = bool
}

# resources variables
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "vpc_id" {
  description = "Id of the VPC"
  type        = string
  default     = ""
}

variable "subnet_details" {
  description = "Details of subnet"
  type = map(object({
    subnet_name = string
    subnet_cidr = string
    subnet_az   = string
    subnet_type = string
  }))
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

variable "nat_gw_details" {
  description = "Details of NAT Gateway"
  type = map(object({
    nat_gw_name = string
    require_aws_eip = bool
    aws_eip_id = string
    subnet_id = string
  }))
}

variable "common_address" {
  description = "Destination CIDR for the default route"
  type        = string
  default     = "0.0.0.0/0"
}

variable "route_table_details" {
    description = "Name of the route table"
    type        = map(object({
        route_table_name = string
        nat_required       = bool
        nat_gw_id         = string
        igw_required       = bool
        igw_id            = string
    }))
  
}
