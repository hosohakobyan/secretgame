
data "aws_ecs_cluster" "secretgame" {
  cluster_name = "secretgame"
  tags = {
    Name = "secretgame"
  }
}

data "aws_lb_target_group" "secretgame_tg" {
  name = "secretgame-lb"
}

data "aws_iam_role" "role" {
  name = "ecsInstanceRole_role"
}