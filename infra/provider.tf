terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "ccccccascxzc"
    key    = "infra/infra.tfstate"
    region = "eu-central-1"
  }
}