
variable "igw_details" {
    description = "Name of the Internet Gateway"
    type = map(object({
        vpc_id = string
        igw_name = string
    }))
}