locals {
  # environment = "dev"
  project     = "networking"
  owner       = "devops"
  cost_center = "platform"
  app_name    = "networking-landing-zone"

  # env_details = {
  #   env         = local.environment 
  #   project     = local.project
  #   owner       = local.owner
  #   cost_center = local.cost_center
  #   app_name    = local.app_name
  # }

  common_tags = {
    # Environment = local.environment
    Project     = local.project
    Owner       = local.owner
    CostCenter  = local.cost_center
    AppName     = local.app_name
    ManagedBy   = "Terraform"
    Terraform   = "true"
  }  

  region_code={
    "eu-central-1" = "euc1"
    "us-east-1"   = "use1"
    "us-west-2"   = "usw2"
  }
}
