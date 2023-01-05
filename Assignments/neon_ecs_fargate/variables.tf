//module neon_vpc variables
variable "cidr_block" {
  type = string
}
variable "instance_tenancy" {
  type = string
}
variable "vpc_name" {
  type = string
}
variable "public_subnet_cidr" {
  type = list(any)
}
variable "availability_zone" {
  type = list(any)
}
variable "private_subnet_cidr" {
  type = list(any)
}

//module ecr_repository variables
variable "ecr_repo_name" {
  type = string
}

//module alb_security_group variables
variable "alb_sg_name" {
  type = string
}
variable "alb_sg_description" {
  type = string
}
variable "alb_sg_ingress_ports" {
  type = list(any)
}

//module alb variables
variable "lb_name" {
  type = string
}
variable "load_balancer_type" {
  type = string
}
variable "target_group_name" {
  type = string
}

//module serive_security_group variables
variable "srv_sg_name" {
  type = string
}
variable "srv_sg_description" {
  type = string
}

variable "srv_sg_ingress_ports" {
  type = list(any)
}

//module ecs_task_definition varaibles
variable "ecs_cluster_name" {
  type = string
}
variable "task_definition_name" {
  type = string
}
variable "ecs_service_name" {
  type = string
}
variable "container_name" {
  type = string
}
variable "container_port" {
  type = string
}
