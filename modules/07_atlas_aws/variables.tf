variable "project_id" {
  type = string
}

variable "existing_aws_iam_role" {
  type = object({
    enabled = bool
    arn     = string
  })
  default = {
    enabled = false
    arn     = "not-enabled"
  }
}
variable "existing_aws_iam_role_arn" {
  type        = string
  description = "Existing AWS IAM role ARN"
  default     = null

  validation {
    condition = (
      var.existing_aws_iam_role_arn == null ||
      can(regex("^arn:aws:iam::[0-9]{12}:role/.+$", var.existing_aws_iam_role_arn))
    )
    error_message = "existing_aws_iam_role_arn must be a valid AWS IAM role ARN when provided."
  }
}

variable "aws_iam_role_name" {
  type        = string
  description = "AWS IAM role name. Use only if you want to create a new IAM role."
  default     = null
  nullable    = true
}


variable "push_based_log_export" {
  type = object({
    bucket_name        = string
    prefix_path        = optional(string)
    enabled            = bool
    bucket_policy_name = optional(string, "AtlasPushBasedLogPolicy")
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  })
  default = {
    enabled     = false
    bucket_name = "not-enabled"
  }
}
