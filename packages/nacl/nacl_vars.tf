variable "network_acl_details" {
    description = "Details of the Network ACL"
    type = map(object({
        vpc_id = string
        network_acl_name = string
        subnets = list(string)
        egress_rules = map(object({
            rule_no = number
            protocol = string
            action = string
            cidr_block = string
            from_port = number
            to_port = number
        }))
        ingress_rules = map(object({
            rule_no = number
            protocol = string
            action = string
            cidr_block = string
            from_port = number
            to_port=number
        }))

    }))
}

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
