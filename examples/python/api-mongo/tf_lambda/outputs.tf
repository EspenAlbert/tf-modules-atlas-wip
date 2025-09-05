output "function_url" {
  value = aws_lambda_function_url.app_url.function_url
}

output "lambda_security_group_id" {
  value = aws_security_group.lambda_sg.id
}

output "lambda_log_group_name" {
  value = aws_cloudwatch_log_group.lambda_log_group.name
}
