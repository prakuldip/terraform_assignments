module "neon_vpc" {
  source = "./MODULES/VPC"
  cidr_block          = var.cidr_block
  instance_tenancy    = var.instance_tenancy
  vpc_name            = var.vpc_name
  public_subnet_cidr  = var.public_subnet_cidr
  availability_zone   = var.availability_zone
  private_subnet_cidr = var.private_subnet_cidr
}
module "ecr_repository" {
  source = "./MODULES/ECR_REPO"
  ecr_repo_name = var.ecr_repo_name
}

resource "null_resource" "image_push" {
  provisioner "local-exec" {
    working_dir = "/mnt/c/ITmigration/cloudethix_devops/terraform/Assignment3_ecs/neon_ecs_fargate/DOCKER/docker-sample-nginx"
    command = "docker image build . -t ${module.ecr_repository.account_id}.dkr.ecr.${module.ecr_repository.region}.amazonaws.com/${var.ecr_repo_name}:latest && docker login --username AWS --password `aws ecr get-login-password --region ${module.ecr_repository.region}` ${module.ecr_repository.account_id}.dkr.ecr.${module.ecr_repository.region}.amazonaws.com && docker push ${module.ecr_repository.account_id}.dkr.ecr.${module.ecr_repository.region}.amazonaws.com/${var.ecr_repo_name}:latest"
    interpreter = ["/bin/bash","-c"]
  }
}

module "alb_security_group" {
  source = "./MODULES/SECURITY_GROUP_CIDR"
  sg_name = var.alb_sg_name
  sg_description = var.alb_sg_description
  vpc_id = module.neon_vpc.vpc_id
  sg_ingress_ports = var.alb_sg_ingress_ports
}

module "alb" {
  source = "./MODULES/ALB"
  lb_name  = var.lb_name
  security_groups = ["${module.alb_security_group.security_group_id}"]
  subnets = module.neon_vpc.public_subnet_ids
  load_balancer_type = var.load_balancer_type
  target_group_name = var.target_group_name
  vpc_id  = module.neon_vpc.vpc_id
}

module "serive_security_group" {
  source = "./MODULES/SECURITY_GROUP_SGID"
  sg_name = var.srv_sg_name
  sg_description = var.srv_sg_description
  vpc_id = module.neon_vpc.vpc_id
  sg_ingress_ports = var.srv_sg_ingress_ports
  source_security_group_id = module.alb_security_group.security_group_id
}

module "ecs_task_definition" {
  source = "./MODULES/ECS"
  ecs_cluster_name = var.ecs_cluster_name
  task_definition_name = var.task_definition_name
  app_image_url = module.ecr_repository.ecr_repo_url
  ecs_service_name = var.ecs_service_name
  target_group_arn = module.alb.target_group_arn
  container_name = var.container_name
  container_port = var.container_port
  service_subnets = module.neon_vpc.private_subnet_ids
  service_security_group_ids = ["${module.serive_security_group.security_group_id}"]
}