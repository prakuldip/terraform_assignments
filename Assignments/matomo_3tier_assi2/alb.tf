resource "aws_lb" "matomo-lb" {
  name                     = "matomo-load-balancer"
  internal                 = false
  security_groups          = [aws_security_group.matomo-lb-sg.id]
  subnets                  = [aws_subnet.pub-subnet[0].id, aws_subnet.pub-subnet[1].id]
  load_balancer_type       = "application"
  idle_timeout             = 60
  enable_deletion_protection = false
}

resource "aws_security_group" "matomo-lb-sg" {
  name        = "lb-security-group"
  description = "This sg allows the http and https traffic internet"
  vpc_id      = aws_vpc.matomo-vpc.id

  dynamic "ingress" {
    for_each = var.lb-sg-ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

#creating the target groups 
resource "aws_lb_target_group" "web-tg" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.matomo-vpc.id

  health_check {
    path                = "/index.html"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

#creating target group attachment
resource "aws_lb_target_group_attachment" "lb-tg-attach" {
  target_group_arn = aws_lb_target_group.web-tg.arn
  target_id        = aws_instance.web-server.id 
}

#creating the listners
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.matomo-lb.arn
  protocol          = "HTTP"
  port              = 80

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-tg.arn
  }
}

//resource "aws_lb_listener" "https" {
//  load_balancer_arn = aws_lb.matomo-lb.arn
//  protocol          = "HTTPS"
//  port              = 443
//
//  default_action {
//    type             = "forward"
//    target_group_arn = aws_lb_target_group.web-tg.arn
//  }
//}


