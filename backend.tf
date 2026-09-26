terraform {
  required_version = ">= 1.16.0"

  backend "s3" {
    bucket       = "first-github-actions-state-bucket"
    key          = "prod/terraform.tfstate"
    region       = "ap-southeast-1"
    use_lockfile = true   # native S3 locking
    encrypt      = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.65"
    }
  }
}