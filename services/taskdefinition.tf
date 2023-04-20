resource "aws_ecs_task_definition" "secgame_backend" {
  family = "secgame_backend"
  container_definitions = jsonencode([
    {
      name      = "secgamenackend"
      image     = "258109438364.dkr.ecr.eu-central-1.amazonaws.com/stage:latest"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    },
  
  ])

  volume {
    name      = "secretgame-storage"
    host_path = "/ecs/secretgame-storage"
  }

#   placement_constraints {
#     type       = "memberOf"
#   }
}

resource "aws_ecs_service" "secretgame_service" {
  name            = "secretgame_service"
  cluster         = data.aws_ecs_cluster.secretgame.id
  task_definition = aws_ecs_task_definition.secgame_backend.arn
  desired_count   = 1
  #iam_role        = data.aws_iam_role.role.arn
  #depends_on      = [aws_iam_role_policy.foo]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = data.aws_lb_target_group.secretgame_tg.arn
    container_name   = "secgamenackend"
    container_port   = 80
  }
}