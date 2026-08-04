variable "nat_gw_details" {
    description = "Details of the NAT Gateways to be created"
    type = map(object({
        nat_gw_name      = string
        aws_eip_id       = string
        subnet_id        = string
        required_eip     = optional(bool, false)
        require_aws_eip  = optional(bool, false)
    }))
}