resource "aws_instance" "app-server" {
  ami           = "ami-0283a57753b18025b"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.pri-subnet[1].id}"
  security_groups = ["${aws_security_group.app-sg.id}"]
}

resource "aws_security_group" "app-sg" {
  name        = "app-security-group"
  description = "This sg allows traffic from web-server at port 8080"
  vpc_id      = aws_vpc.matomo-vpc.id

    ingress {
      from_port   = 8080
      to_port     = 8080
      protocol    = "TCP"
      security_groups = ["${aws_security_group.web-sg.id}"]
    }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    }
}
