resource "aws_ecr_repository" "this_ecr_repo" {
  name                 = var.ecr_repo_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

