output "ecr_registry_urls" {
  value = sort([for name, repo in aws_ecr_repository.repos : repo.repository_url])
}
