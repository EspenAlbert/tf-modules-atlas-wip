variable "project_id" {
  type = string
}
# Atlas Region
variable "atlas_region" {
  type        = string
  description = "Atlas region where resources will be created"
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

variable "aws_encryption_at_rest" {
  type = object({
    enabled                    = bool
    customer_master_key_id     = optional(string)
    enabled_for_search_nodes   = optional(bool, false)
    require_private_networking = optional(bool, false)
  })
  nullable = false
  default = {
    enabled = false
  }
}
