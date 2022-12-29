resource "aws_lb" "this-lb" {
  name                     = var.lb_name
  internal                 = false
  //security_groups          = [aws_security_group.matomo-lb-sg.id]
  security_groups          = var.security_groups
  //subnets                  = [aws_subnet.pub-subnet[0].id, aws_subnet.pub-subnet[1].id]
  subnets                  = var.subnets
  load_balancer_type       = var.load_balancer_type
  idle_timeout             = 60
  enable_deletion_protection = false
}