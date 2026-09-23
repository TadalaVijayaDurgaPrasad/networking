
variable "igw_details" {
    description = "Name of the Internet Gateway"
    type = map(object({
        vpc_id = string
        igw_name = string
    }))
}

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}