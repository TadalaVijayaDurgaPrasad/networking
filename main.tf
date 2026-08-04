provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "./module/ec2_instance"
  for_each = var.servers
  ami_id = each.value.ami_id
  instance_type = each.value.instance_type
  name = each.value.name
}
# resource "aws_instance" "virtual_server" {
#   for_each = var.servers

#   ami           = each.value.ami_id
#   instance_type = each.value.instance_type

#   tags = {
#     Name = each.value.name
#   }
# }
