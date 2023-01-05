variable "sg_name" {
  type = string
}
variable "sg_description" {
  type = string
}

variable "vpc_id" {}

variable "sg_ingress_ports" {
  type = list(any)
}
variable "source_security_group_id" {
  type = string
}
