resource "aws_network_acl" "this" {
  for_each   = var.network_acl_details
  vpc_id     = each.value.vpc_id
  subnet_ids = each.value.subnets

  lifecycle {
    prevent_destroy       = false
    create_before_destroy = false
  }

  dynamic "egress" {
    for_each = each.value.egress_rules
    content {
      rule_no    = egress.value.rule_no
      protocol   = egress.value.protocol
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }

  dynamic "ingress" {
    for_each = each.value.ingress_rules
    content {
      rule_no    = ingress.value.rule_no
      protocol   = ingress.value.protocol
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  tags = merge(var.common_tags, {
    Name = each.value.network_acl_name
  })
}

output "nacl_id" {
  value = {
    for k, v in aws_network_acl.this : k => v.id
  }
}