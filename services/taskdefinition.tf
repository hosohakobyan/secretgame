resource "aws_ecs_task_definition" "task_definition" {
  family = var.family
  container_definitions = jsonencode([
    {
      name      = var.task_def_name
      image     = var.task_def_image
      cpu       = var.task_def_cpu
      memory    = var.task_def_memory
      environment = var.env-variables
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.hostPort
        }
      ]
    },

  ])

  volume {
    name      = "${var.env}-storage"
    host_path = var.host_path
  }


}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.env}_service"
  cluster         = data.aws_ecs_cluster.heimlich_stage.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 1
  iam_role        = data.aws_iam_role.role.arn


  ordered_placement_strategy {
    type  = var.ordered_placement_type
    field = var.ordered_placement_field
  }

  load_balancer {
    target_group_arn = data.aws_lb_target_group.heimlich_stage_tg.arn
    container_name   = var.lb_container_name
    container_port   = var.lb_container_port
  }
}