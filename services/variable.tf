variable "env" {
  default = "heimlich_stage"
  type    = string

}
#===========task definition=================
variable "family" {
  default = "heimlich_stage"
  type    = string

}

variable "task_def_name" {
  default = "heimlich_stage"
  type    = string

}

variable "task_def_image" {
  default = "258109438364.dkr.ecr.eu-central-1.amazonaws.com/stage:latest"
  type    = string

}

variable "task_def_cpu" {
  default = 10
  type    = number

}

variable "task_def_memory" {
  default = 512
  type    = number

}

variable "container_port" {
  default = 80
  type    = number

}

variable "hostPort" {
  default = 80
  type    = number

}

variable "host_path" {
  default = "/ecs/heimlichstage-storage"
  type    = string

}

#===================ecs service==============
variable "ordered_placement_type" {
  default = "binpack"
  type    = string

}

variable "ordered_placement_field" {
  default = "cpu"
  type    = string

}

variable "lb_container_name" {
  default = "heimlichstage"
  type    = string
}

variable "lb_container_port" {
  default = 80
  type    = number

}

variable "lb_tg_name" {
  type    = string
  default = "heimlich_stage"
}