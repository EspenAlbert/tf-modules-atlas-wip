output "ecr_registry_urls" {
  value = sort([for name, repo in aws_ecr_repository.repos : repo.repository_url])
}

output "function_url" {
  value = aws_lambda_function_url.app_url.function_url
}
