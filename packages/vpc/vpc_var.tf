variable "region" {
    description = "AWS region"
    type        = string
}
variable "region_code" {
  description = "Region code mapping"
  type        = map(string)
  default     = {}
}
variable "vpc_name" {
    description = "Name of the VPC"
    type = string
}
variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
}
variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}

