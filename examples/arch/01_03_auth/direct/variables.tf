variable "atlas_project_id" {
  type = string
}

variable "aws_iam_role_arn" {
  type = string
  validation {
    condition = (
      can(regex("^arn:aws:iam::[0-9]{12}:role/.+$", var.aws_iam_role_arn))
    )
    error_message = "aws_iam_role_arn must be a valid AWS IAM role ARN when provided."
  }
}
