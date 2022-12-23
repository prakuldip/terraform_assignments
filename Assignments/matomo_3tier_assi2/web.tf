resource "aws_instance" "web-server" {
  ami           = "ami-0283a57753b18025b"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.pub-subnet[0].id}"
  security_groups = ["${aws_security_group.web-sg.id}"]
}

resource "aws_security_group" "web-sg" {
  name        = "weg-security-group"
  description = "This sg allows the http and https traffic from alb"
  vpc_id      = aws_vpc.matomo-vpc.id

  dynamic "ingress" {
    for_each = var.web-sg-ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      security_groups = ["${aws_security_group.matomo-lb-sg.id}"]
    }
  }

    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
}

