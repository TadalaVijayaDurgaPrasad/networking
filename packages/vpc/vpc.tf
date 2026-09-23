resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  lifecycle {
    prevent_destroy       = false
    create_before_destroy = false
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    Name = "aaip-infra-${var.region_code[var.region]}-${var.common_tags["Project"]}-${var.environment}-vpc"
  })
}

output "vpc_id" {
  value = aws_vpc.this.id
}