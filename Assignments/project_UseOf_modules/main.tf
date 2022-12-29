module "kordas_vpc" {
  source                               = "./modules/01_vpc"
  cidr_block = var.cidr_block
  instance_tenancy = var.instance_tenancy
  vpc_name = var.vpc_name
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone = var.availability_zone
  private_subnet_cidr = var.private_subnet_cidr
}

module "lb_sg" {
  source                               = "./modules/02_securitygroup"
  sg_name = var.lb_sg_name
  sg_description = var.lb_sg_description
  vpc_id = module.kordas_vpc.vpc_id
  //sg_rules = var.lb_security_group_rules
  sg_ports = var.lb_sg_ports
}

module "web_sg" {
  source                               = "./modules/02_securitygroup"
  sg_name = var.web_sg_name
  sg_description = var.web_sg_description
  vpc_id = module.kordas_vpc.vpc_id
  //sg_rules = var.web_security_group_rules
  sg_ports = var.web_sg_ports
}

module "app_sg" {
  source                               = "./modules/02_securitygroup"
  sg_name = var.app_sg_name
  sg_description = var.app_sg_description
  vpc_id = module.kordas_vpc.vpc_id
  //sg_rules = var.app_security_group_rules
  sg_ports = var.app_sg_ports
}

module "rds_sg" {
  source                               = "./modules/02_securitygroup"
  sg_name = var.rds_sg_name
  sg_description = var.rds_sg_description
  vpc_id = module.kordas_vpc.vpc_id
  //sg_rules = var.app_security_group_rules
  sg_ports = var.rds_sg_ports
}

module "lb_for_webserver" {
  source                               = "./modules/05_lb"
  lb_name = var.lb_name
  security_groups = ["${module.lb_sg.security_group_id}"]
  subnets = module.kordas_vpc.public_subnet_ids
  load_balancer_type = var.load_balancer_type
}

module "kordas_key" {
  source                               = "./modules/04_keypair"
  key_name = "beinghuman"
  pub_key_path = var.pub_key_path
}

module "web_server" {
  source                               = "./modules/03_instance"
  ami_id = var.web_ami_id
  instance_type = var.web_instance_type
  subnet_id = "${module.kordas_vpc.public_subnet_id}"
  security_group_ids = ["${module.web_sg.security_group_id}"]
  key_name = module.kordas_key.key_name
}

module "app_server" {
  source                               = "./modules/03_instance"
  ami_id = var.app_ami_id
  instance_type = var.app_instance_type
  subnet_id = "${module.kordas_vpc.private_subnet_id}"
  security_group_ids = ["${module.app_sg.security_group_id}"]
  key_name = module.kordas_key.key_name
}

module "kordas_rds" {
  source                               = "./modules/06_rds"
  subnet_ids = module.kordas_vpc.private_subnet_ids
  availability_zone = var.availability_zone
  vpc_security_group_ids = ["${module.rds_sg.security_group_id}"]
}

module "kordas_s3" {
  source                               = "./modules/07_s3"
  bucket_name = var.s3_bucket_name
}




