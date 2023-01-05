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