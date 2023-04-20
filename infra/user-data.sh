#!/bin/bash
# sudo yum update -y
# sudo amazon-linux-extras install -y ecs
# sudo yum install -y ecs-init
# sudo service docker start
# sudo start ecs
echo ECS_CLUSTER=secretgame >> /etc/ecs/ecs.config
echo "ECS_AVAILABLE_LOGGING_DRIVERS=[\"awslogs\",\"fluentd\"]" >> /etc/ecs/ecs.config
echo "ECS_CONTAINER_STOP_TIMEOUT=10m" >> /etc/ecs/ecs.config
