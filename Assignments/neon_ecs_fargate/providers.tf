terraform {
  required_version = ">= 0.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.48.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    local = {
      source = "hashicorp/local"
      version = "2.2.3"
    }
  }
}

provider "aws" {
  # Configuration options
}
provider "random" {
  # Configuration options
}
provider "local" {
  # Configuration options
}