locals {
  image_without_tag = split(":", var.image_uri)[0]
  repo_url_names    = { for repo in aws_ecr_repository.repos : repo.repository_url => repo.name }
  name              = local.repo_url_names[local.image_without_tag]
  log_group_name    = "/aws/lambda/${local.name}"
}


resource "aws_security_group" "lambda_sg" {
  name        = "lambda-sg-${local.name}"
  description = "Allow Lambda outbound traffic"
  vpc_id      = var.vpc_id
  # Lambda functions do not require inbound rules.
  # Allow all outbound traffic so the Lambda can reach private resources.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lambda_function" "app" {
  function_name = local.name
  package_type  = "Image"
  role          = var.lambda_execution_role_arn
  image_uri     = var.image_uri
  architectures = ["arm64"]
  timeout       = 30 # adjust as needed
  memory_size   = 512

  environment {
    variables = var.env_vars
  }

  vpc_config {
    subnet_ids         = var.vpc_subnet_ids
    security_group_ids = [aws_security_group.lambda_sg.id]
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
