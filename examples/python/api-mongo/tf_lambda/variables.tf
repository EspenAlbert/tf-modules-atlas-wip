variable "aws_region" {
  type = string
}

variable "name" {
  type    = string
  default = "api-mongo-python"
}

variable "image_uri" {
  description = "ECR URI with image and tag"
  type        = string
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "Prefer a private subnet that can reach the private endpoint"
}

variable "vpc_id" {
  type = string
}

variable "env_vars" {
  type      = map(string)
  default   = {}
  sensitive = true
}

variable "lambda_execution_role_arn" {
  type = string
}
