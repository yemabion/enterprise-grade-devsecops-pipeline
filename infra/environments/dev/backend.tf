
terraform {
  backend "s3" {
    bucket       = "enterprise-grade-devsecops-tfstate-581237505507-us-east-1"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
