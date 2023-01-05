resource "aws_lb" "this-lb" {
  name     = var.lb_name
  internal = false
  //security_groups          = [aws_security_group.matomo-lb-sg.id]
  security_groups = var.security_groups
  //subnets                  = [aws_subnet.pub-subnet[0].id, aws_subnet.pub-subnet[1].id]
  subnets                    = var.subnets
  load_balancer_type         = var.load_balancer_type
  idle_timeout               = 60
  enable_deletion_protection = false
}

//target group
resource "aws_lb_target_group" "this_target_group" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/index.html"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

//listners
resource "aws_lb_listener" "this_listner" {
  load_balancer_arn = aws_lb.this-lb.arn
  protocol          = "HTTP"
  port              = 80

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this_target_group.arn
  }
}