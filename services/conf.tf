terraform {
  backend "s3" {
    bucket = "ccccccascxzc"
    key    = "infra/infra1.tfstate"
    region = "eu-central-1"
  }
}
