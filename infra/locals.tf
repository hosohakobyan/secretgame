locals {
  user_data = <<-EOT
    #!/bin/bash
    echo ECS_CLUSTER=${var.env} >> /etc/ecs/ecs.config
    echo "ECS_AVAILABLE_LOGGING_DRIVERS=[\"awslogs\",\"fluentd\"]" >> /etc/ecs/ecs.config
    echo "ECS_CONTAINER_STOP_TIMEOUT=10m" >> /etc/ecs/ecs.config
  EOT
}