
provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project   = "Enterprise-Grade-DevSecOps"
      ManagedBy = "Terraform"
      Purpose   = "Terraform-State-Backend"
    }
  }
}
