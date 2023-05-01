
data "aws_ecs_cluster" "heimlich_stage" {
  cluster_name = "heimlich_stage"
  tags = {
    Name = "heimlich_stage"
  }
}

data "aws_lb_target_group" "heimlich_stage_tg" {
  name = "heimlich_stage_lb"
}

data "aws_iam_role" "role" {
  name = "ecsInstanceRole_role"
}