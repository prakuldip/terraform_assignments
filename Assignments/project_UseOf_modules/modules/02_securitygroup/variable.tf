variable "sg_name" {
  type = string
}
variable "sg_description" {
  type = string
}
/*
variable "sg_rules" {
  type = list(map(string))
}
*/

variable "vpc_id" {}

variable "sg_ports" {
  type = list
}