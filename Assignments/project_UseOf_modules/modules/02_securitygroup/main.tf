resource "aws_security_group" "this_sg" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "this_ingress" {
  count = length(var.sg_ports)
  type              = "ingress"
  from_port         = var.sg_ports[count.index]
  to_port           = var.sg_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this_sg.id
}

resource "aws_security_group_rule" "this_egress" {
  count = length(var.sg_ports)
  type              = "egress"
  from_port         = var.sg_ports[count.index]
  to_port           = var.sg_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this_sg.id
}