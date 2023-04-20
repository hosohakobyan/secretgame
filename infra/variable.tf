variable "env" {
  default = "secretgame"
  type    = string

}

variable "region" {
  type    = string
  default = "eu-central-1"

}

#=================public==============
variable "cidr_block" {
  default = "10.0.0.0/16"
  type    = string

}

variable "public_cidr_a" {
  default = "10.0.10.0/24"
  type    = string

}

variable "public_cidr_b" {
  default = "10.0.11.0/24"
  type    = string

}

variable "availability_zone_public_a" {
  default = "eu-central-1a"
  type    = string

}

variable "availability_zone_public_b" {
  default = "eu-central-1b"
  type    = string

}

variable "route_cidr" {
  default = "0.0.0.0/0"
  type    = string

}
#================private===============
variable "private_cidr_a" {
  default = "10.0.20.0/24"
  type    = string

}

variable "private_cidr_b" {
  default = "10.0.21.0/24"
  type    = string

}

variable "availability_zone_private-a" {
  default = "eu-central-1a"
  type    = string

}

variable "availability_zone_private-b" {
  default = "eu-central-1b"
  type    = string

}

variable "route_cidr_private" {
  default = "0.0.0.0/0"
  type    = string

}
#========alb-tg========================
variable "alb_tg_name" {
  default = "secretgame-lb"
  type    = string

}

variable "alb_tg_port" {
  default = 80
  type    = number

}

variable "alb_tg_protocol" {
  default = "HTTP"
  type    = string

}

variable "target_type" {
  default = "instance"
  type = string
  
}


variable "health_interval" {
  default = 70
  type    = number

}

variable "health_port" {
  default = 80
  type    = number

}

variable "healthy_threshold" {
  default = 2
  type    = number

}

variable "unhealthy_threshold" {
  default = 2
  type    = number

}

variable "healthy_timeout" {
  default = 60
  type    = number

}

variable "healthy_protocol" {
  default = "HTTP"
  type    = string

}

variable "healthy_matcher" {
  default = "200,202"
  type    = string

}
#===========ALB=========================

variable "alb_name" {
  default = "secretgame-lb"
  type    = string

}

variable "alb_type" {
  default = "application"
  type    = string

}

variable "tags_name" {
  default = "secretgame-appLoadbalancer"
  type    = string

}
#=============alb-lis===================
variable "alb_lis_port" {
  default = 80
  type    = number

}

variable "alb_lis_protocol" {
  default = "HTTP"
  type    = string

}

variable "default_action_type" {
  default = "forward"
  type    = string

}
#============sg=======================
variable "allow_ports_alb" {
  description = "List of Ports to open for alb"
  type        = list(any)
  default     = ["80", "443", "8080", ]
}

variable "secretgame_sg_ports" {
  description = "List of Ports to open for sg"
  type        = list(any)
  default     = ["80", "22", "8080", "443"]
}

#=======lp============================

variable "lt_name" {
  default = "secretgame"
  type    = string

}

variable "instance_type" {
  default = "t3.large"
  type    = string

}

variable "image_id" {
  type = map(string)
  default = {
    "eu-central-1" = "ami-0479e02f9b310c857"

  }
}

variable "device_name" {
  default = "/dev/xvda"
  type    = string

}

#=========asg=========================

variable "asg-name" {
  default = "secretgame"
  type    = string

}

variable "min-size" {
  default = 1
  type    = number

}

variable "max-size" {
  default = 1
  type    = number

}

variable "desired_capacity" {
  default = 1
  type    = number

}

variable "health_check_type" {
  default = "ELB"
  type    = string

}

variable "metrics_granularity" {
  default = "1Minute"
  type    = string

}

variable "key_ec2" {
  default = "frankfurt"
  type    = string

}

variable "volume_type" {
  default = "gp2"
  type    = string

}

variable "volume_size" {
  default = 30
  type    = number

}

variable "on_demand_base_capacity" {
  default = 0
  type    = number

}

variable "on_demand_percentage_above_base_capacity" {
  default = 20
  type    = number

}

variable "lt_version" {
  default = "$Latest"
  type    = string

}

#=======capacity_provider============

variable "capacity_provider_name" {
  default = "secretgame_capacity_provider"
  type    = string

}

variable "managed_termination_protection" {
  default = "ENABLED"
  type    = string

}

variable "managed_scaling_status" {
  default = "ENABLED"
  type    = string

}

variable "managed_scaling_target" {
  default = 90
  type    = number

}

variable "maximum_scaling_step_size" {
  default = 1
  type    = number

}

#========cluster name=======
variable "cluster_name" {
  type    = string
  default = "secretgame"

}

#===== UP======================================
variable "scaling_adjustment-up" {
  default = 1
  type    = number

}

variable "name-up-policy" {
  default = "secretgame_policy_up"
  type    = string

}

variable "adjustment_type-up" {
  default = "ChangeInCapacity"
  type    = string

}

variable "cooldown-up" {
  default = 60
  type    = number

}

variable "evaluation_periods-up" {
  default = 2
  type    = number

}

variable "alarm_name-up" {
  default = "secretgame_cpu_alarm_up"
  type    = string

}

variable "comparison_operator-up" {
  default = "GreaterThanOrEqualToThreshold"
  type    = string

}

variable "metric_name-up" {
  default = "CPUUtilization"
  type    = string

}


variable "namespace-up" {
  default = "AWS/EC2"
  type    = string

}

variable "period-up" {
  default = 120
  type    = number


}


variable "statistic-up" {
  default = "Average"
  type    = string

}

variable "threshold-up" {
  default = 70
  type    = number


}

variable "alarm_description_up" {
  default = "This metric monitor ec2 instance cpu utilization"
  type    = string

}


#========DOWN====================================

variable "name-down" {
  default = "secretgame_policy_down"
  type    = string

}

variable "scaling_adjustment-down" {
  default = -1
  type    = number

}

variable "adjustment_type-down" {
  default = "ChangeInCapacity"
  type    = string

}

variable "cooldown-down" {
  default = 60
  type    = number

}

variable "alarm_name-down" {
  default = "secretgame_cpu_alarm_down"
  type    = string

}

variable "comparison_operator-down" {
  default = "LessThanOrEqualToThreshold"
  type    = string

}

variable "evaluation_periods-down" {
  default = 2
  type    = number

}

variable "metric_name-down" {
  default = "CPUUtilization"
  type    = string

}

variable "namespace-down" {
  default = "AWS/EC2"
  type    = string

}

variable "period-down" {
  default = 120
  type    = number

}

variable "statistic-down" {
  default = "Average"
  type    = string

}

variable "threshold-down" {
  default = 30
  type    = number

}

variable "alarm_description_down" {
  default = "This metric monitor ec2 instance cpu utilization"
  type    = string

}

#=================rds=======================

variable "rds_password_name" {
  default = "secretgame"
  type    = string

}

variable "identifier" {
  default = "prod-rds"
  type    = string

}

variable "allocated_storage" {
  default = 20
  type    = number

}

variable "storage_type" {
  default = "gp2"
  type    = string

}

variable "engine" {
  default = "mysql"
  type    = string

}

variable "engine_version" {
  default = "5.7"
  type    = string

}

variable "instance_class" {
  default = "db.t2.micro"
  type    = string

}

variable "db_name" {
  default = "secretgame"
  type    = string

}

variable "username" {
  default = "admin"
  type    = string

}

variable "parameter_group_name" {
  default = "default.mysql5.7"
  type    = string

}

#===============password parametr=========

variable "password_length" {
  default = 12
  type    = number

}

variable "override_special" {
  default = "!#$&"
  type    = string

}

variable "name-key-rds" {
  default = "secretgame-rds-password"
  type    = string

}

variable "password_description" {
  default = "master password for rds mysql"
  type    = string

}

variable "password_type" {
  default = "SecureString"
  type    = string

}

#==================role==================

variable "policies" {
  type = list(string)
  default = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role",
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
  ]
}
