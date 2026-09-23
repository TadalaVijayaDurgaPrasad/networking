variable "region" {
    description = "AWS region"
    type        = string
}
variable "region_code" {
  description = "Region code mapping"
  type        = map(string)
  default     = {}
}
variable "environment" {
    description = "Name of the environment"
    type = string
}
variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
}
variable "prevent_destroy" {
    description = "Prevent destroy flag for the VPC"
    type        = bool
    default     = false
}
variable "create_before_destroy" {
    description = "Create before destroy flag for the VPC"
    type        = bool
    default     = false
}
variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}


