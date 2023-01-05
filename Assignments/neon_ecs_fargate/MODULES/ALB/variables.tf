variable "lb_name" {
  type = string
}
variable "security_groups" {
  type = list(string)
}
variable "subnets" {
  type = list(string)
}
variable "load_balancer_type" {
  type = string
}
variable "target_group_name" {
  type = string
}
variable "vpc_id" {}



