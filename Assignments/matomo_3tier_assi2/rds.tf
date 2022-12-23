resource "aws_db_subnet_group" "pri-subnet-grp" {
  name       = "private-subnet-group"
  subnet_ids = [aws_subnet.pri-subnet[0].id, aws_subnet.pri-subnet[1].id]
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  availability_zone    = "us-east-2b"
  identifier           = "matomo-rds"   
  db_name              = "matomodb1"    
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "root"
  password             = "foobarbaz"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.pri-subnet-grp.name
  vpc_security_group_ids = ["${aws_security_group.rds-sg.id}"]
  port                  = 3306
  publicly_accessible   = false
  deletion_protection   = false
  backup_retention_period = 0
  auto_minor_version_upgrade = true

}

resource "aws_security_group" "rds-sg" {
  name        = "rds-security-group"
  description = "This sg allows traffic from app-server at port 3306"
  vpc_id      = aws_vpc.matomo-vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    security_groups = ["${aws_security_group.app-sg.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
