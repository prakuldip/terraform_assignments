//module vpc variables
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
  type = list
}
variable "availability_zone" {
  type = list
}
variable "private_subnet_cidr" {
  type = list
}

//module lb_sg variables
variable "lb_sg_name" {
  type = string
}
variable "lb_sg_description" {
  type = string
}
variable "lb_sg_ports" {
  type = list
}

//module web_sg variables
variable "web_sg_name" {
  type = string
}
variable "web_sg_description" {
  type = string
}
variable "web_sg_ports" {
  type = list
}

//module app_sg variables
variable "app_sg_name" {
  type = string
}
variable "app_sg_description" {
  type = string
}
variable "app_sg_ports" {
  type = list
}

//module rds_sg variables
variable "rds_sg_name" {
  type = string
}
variable "rds_sg_description" {
  type = string
}
variable "rds_sg_ports" {
  type = list
}

//lb variables
variable "lb_name" {
  type = string
}
variable "load_balancer_type" {
  type = string
}

//key pair variables
variable "pub_key_path" {
  type = string
}

//web server variables
variable "web_ami_id" {
  type = string
}
variable "web_instance_type" {
  type = string
}

//app server variables
variable "app_ami_id" {
  type = string
}
variable "app_instance_type" {
  type = string
}

//s3 bucket variables
variable "s3_bucket_name" {
  type = string
}

