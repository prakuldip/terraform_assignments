//module vpc values
cidr_block = "10.0.0.0/16"
instance_tenancy = "default"
vpc_name = "kordas-vpc"
public_subnet_cidr = ["10.0.1.0/24","10.0.2.0/24"]
availability_zone = ["us-east-2a","us-east-2b"]
private_subnet_cidr = ["10.0.3.0/24","10.0.4.0/24"]

//module lb_sg values
  lb_sg_name = "lb-security-group"
  lb_sg_description = "This allows http and https requests to lb"
  lb_sg_ports = ["80","443"]
  
//module web_sg values
  web_sg_name = "web-security-group"
  web_sg_description = "This allows http and https requests to web server"
  web_sg_ports = ["80","443"]

//module app_sg values
  app_sg_name = "app-security-group"
  app_sg_description = "This allows traffic on port 8080 on app server"
  app_sg_ports = ["8080"]

//module rds_sg values
  rds_sg_name = "rds-security-group"
  rds_sg_description = "This allows traffic on port 3306 on rds"
  rds_sg_ports = ["3306"]

  //module lb_for_webserver values
  lb_name = "alb-for-web-servers"
  load_balancer_type = "application"

//module kordas_key values
  pub_key_path = "/root/.ssh/id_rsa.pub"

  //module web_server values
  web_ami_id = "ami-0283a57753b18025b"
  web_instance_type = "t2.micro"

  //module app_server values
  app_ami_id = "ami-0283a57753b18025b"
  app_instance_type = "t2.small"

  //module kordas_s3 values
  s3_bucket_name = "kordas-mum-bucket"