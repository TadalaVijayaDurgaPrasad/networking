variable "servers" {
  description = "Map of EC2 instance definitions to create"
  type = map(object({
    ami_id        = string
    instance_type = string
    name          = string
  }))
}