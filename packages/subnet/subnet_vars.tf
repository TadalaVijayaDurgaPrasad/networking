variable "subnet_details" {
    description = "Details of the subnets to be created"
    type = map(object({
        vpc_id = string
        subnet_az = string
        subnet_cidr = string
        subnet_name = string
        subnet_type = string
    }))
}