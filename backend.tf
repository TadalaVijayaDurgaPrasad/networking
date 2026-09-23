terraform {
  backend "s3" {
    bucket       = "terraform-state-753805950551-ap-northeast-3-an"
    key          = "clients/default/environments/terraform.tfstate"
    region       = "ap-northeast-3"
    encrypt      = true
    use_lockfile = true
  }
}

# Use a client-specific key when running for a tenant, for example:
# terraform init -reconfigure -backend-config="key=clients/ajb/networking/terraform.tfstate"
# terraform init -reconfigure -backend-config="key=clients/dtcl/networking/terraform.tfstate"
