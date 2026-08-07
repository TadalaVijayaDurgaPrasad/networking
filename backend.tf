terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-753805950551-eu-central-1-an"
    key = "networking/terraform.tfstate"
    region = "eu-central-1"
    encrypt = true
    use_lockfile = true
    
  }
}