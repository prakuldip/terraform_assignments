output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
output "region" {
  value = data.aws_region.current.name
}

output "ecr_repo_url" {
  value = aws_ecr_repository.this_ecr_repo.repository_url
}