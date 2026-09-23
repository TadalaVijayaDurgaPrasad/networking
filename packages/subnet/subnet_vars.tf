variable "region" {
    description = "AWS region"
    type        = string
}
variable "region_code" {
  description = "Region code mapping"
  type        = map(string)
  default     = {}
}

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

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
