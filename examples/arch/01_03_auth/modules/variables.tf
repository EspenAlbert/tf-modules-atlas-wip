variable "atlas_project_id" {
  type = string
}

variable "aws_iam_role_arn" {
  type        = string
  description = "Full ARN of the AWS IAM role to be mapped to an Atlas database user."
  validation {
    # Accept commercial, GovCloud and China partitions and the full character set
    condition = can(
      regex("^arn:aws(-us-gov|-cn)?:iam::[0-9]{12}:role/[\\w+=,.@\\-_/]+$", var.aws_iam_role_arn)
    )
    error_message = "aws_iam_role_arn must be a valid AWS IAM role ARN when provided."
  }
}
