variable "web-sg-ingress_rules" {
  type = list(map(string))

  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "TCP"
    },
  ]
}

variable "lb-sg-ingress_rules" {
  type = list(map(string))

  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "TCP"
    },
  ]
}

