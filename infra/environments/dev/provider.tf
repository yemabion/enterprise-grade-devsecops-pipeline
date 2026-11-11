
provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project     = "Enterprise-Grade-DevSecOps"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}
