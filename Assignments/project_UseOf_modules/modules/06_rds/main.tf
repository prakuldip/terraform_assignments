resource "aws_db_subnet_group" "this_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "random_password" "password" {
  length  = 16
  special = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_db_instance" "this_rds" {
  allocated_storage    = 10
  availability_zone    = var.availability_zone[0]
  identifier           = "kordas-rds"   
  db_name              = "kordasdb1"    
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "root"
  password             = random_password.password.result
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.this_subnet_group.name
  vpc_security_group_ids = var.vpc_security_group_ids
  port                  = 3306
  publicly_accessible   = false
  deletion_protection   = false
  backup_retention_period = 0
  auto_minor_version_upgrade = true
}