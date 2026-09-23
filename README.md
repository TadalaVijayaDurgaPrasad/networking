important links:
terraform AWS resources link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
it is used to get help on creating AWS resources using terraform


# terraform init -reconfigure -backend-config="key=clients/{client}/{environment}/terraform.tfstate"
# terraform apply -var-file="stage_vars.tfvars"
# terraform destroy -var-file="stage_vars.tfvars"

# aaip-infra-<region_code>-<project>-<environment>-<resource_type>

