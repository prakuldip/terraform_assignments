//cluster variables
variable "ecs_cluster_name" {
  type = string
}

//task definition variables
variable "task_definition_name" {
  type = string
}

variable "app_image_url" {
  type = string
}

//ecs service variables
variable "ecs_service_name" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_port" {
  type = string
}

variable "service_subnets" {
  type = list(any)
}

variable "service_security_group_ids" {
  type = list(any)
}



/*
variable "vpc_id" {
  type = string
}

variable "subnet_ids_for_ecs_cluster" {
  type = list
}
*/

