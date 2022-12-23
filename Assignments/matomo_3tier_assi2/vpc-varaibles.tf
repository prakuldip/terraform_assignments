variable "cidr-pub" {
    type = list(string)
    default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "cidr-pri" {
    type = list(string)
    default = ["10.0.3.0/24","10.0.4.0/24"]
}

variable "az" {
    type = list(string)
    default = ["us-east-2b","us-east-2a"]
}