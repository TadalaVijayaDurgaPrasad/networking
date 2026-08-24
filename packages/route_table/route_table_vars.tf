variable "route_table_details" {
    description = "Details of the route tables to be created"
    type = map(object({
        vpc_id = string
        route_cidr = string
        gateway_id = string
    }))
}
