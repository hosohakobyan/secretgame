terraform {
  backend "s3" {
    bucket = "ccccccascxzc"
    key    = "infra/infra1.tfstate"
    region = "eu-central-1"
  }
}

data "aws_ecs_cluster" "secretgame" {
    cluster_name = "secretgame"
    tags = {
      Name = "secretgame"
    }
}

variable "lb_tg_name" {
  type    = string
  default = "secretgame"
}

data "aws_lb_target_group" "secretgame_tg" {
  name = var.lb_tg_name
}
