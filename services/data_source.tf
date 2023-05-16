
data "aws_ecs_cluster" "ecs_cluster" {
  cluster_name = "heimlich_stage"
  tags = {
    Name = "heimlich_stage"
  }
}

data "aws_lb_target_group" "target_group" {
  name = "heimlich_stage_lb"
}

data "aws_iam_role" "role" {
  name = "ecsInstanceRole_role"
}