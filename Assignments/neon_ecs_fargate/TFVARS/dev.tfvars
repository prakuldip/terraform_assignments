//neon_vpc values
cidr_block          = "10.0.0.0/16"
instance_tenancy    = "default"
vpc_name            = "neon-vpc"
public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zone   = ["us-east-2a", "us-east-2b"]
private_subnet_cidr = ["10.0.3.0/24", "10.0.4.0/24"]

//ecr values
ecr_repo_name = "neon-nginx-app"

//alb_security_group values
alb_sg_name = "neon-alb-sg"
alb_sg_description = "This sg allows http and https traffic form all"
alb_sg_ingress_ports = ["80"]

//alb values
lb_name = "neon-lb"
load_balancer_type = "application"
target_group_name = "neon-alb-tg"

//service security group values
srv_sg_name = "neon-service-sg"
srv_sg_description = "This sg allows traffic from alb-sg on port 80"
srv_sg_ingress_ports = ["80"]

//task definitin values
ecs_cluster_name = "neon-cluster"
task_definition_name = "neon-task-definition"
ecs_service_name = "neon-service"
container_name = "app-container"
container_port = "80"