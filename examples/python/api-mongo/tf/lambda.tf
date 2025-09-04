variable "image_uri" {
  description = "ECR URI with image and tag"
  type        = string
}

locals {
  image_without_tag = split(":", var.image_uri)[0]
  repo_url_names    = { for repo in aws_ecr_repository.repos : repo.repository_url => repo.name }
  name              = local.repo_url_names[local.image_without_tag]
  log_group_name    = "/aws/lambda/${local.name}"
  policy_arns = {
    cloudwatch_logs_policy = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    ecr_pull               = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  }
}

variable "env_vars" {
  type      = map(string)
  default   = {}
  sensitive = true
}

resource "aws_iam_role" "lambda_exec" {
  name               = "lambda_exec_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": { "Service": "lambda.amazonaws.com" },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attachments" {
  for_each   = local.policy_arns
  
  policy_arn = each.value
  role       = aws_iam_role.lambda_exec.name
}

resource "aws_lambda_function" "app" {
  function_name = local.name
  package_type  = "Image"
  role          = aws_iam_role.lambda_exec.arn
  image_uri     = var.image_uri
  architectures = ["arm64"]
  timeout       = 30 # adjust as needed
  memory_size   = 512
  
  environment {
    variables = var.env_vars
  }
}

resource "aws_lambda_function_url" "app_url" {
  function_name      = aws_lambda_function.app.function_name
  authorization_type = "NONE"
  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive", "content-type"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = local.log_group_name
  retention_in_days = 7
}
