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

variable "encryption_at_rest" {
  type = object({
    enabled                    = bool
    aws_kms_key_id             = string
    require_private_networking = optional(bool, true)
    enabled_for_search_nodes   = optional(bool, true)
    enable_private_endpoint    = optional(bool, true)
  })
  default = {
    enabled                    = false
    aws_kms_key_id             = ""
    require_private_networking = true
    enabled_for_search_nodes   = true
    enable_private_endpoint    = true
  }
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

variable "atlas_region" {
  type        = string
  description = "Atlas region, required when private link is enabled"
  default     = ""
}

variable "privatelink_with_existing_vpc_endpoint" {
  type = object({
    enabled                           = optional(bool)
    existing_vpc_endpoint_id          = optional(string)
    add_vpc_cidr_block_project_access = optional(bool, false)
  })
  default = {
    enabled                           = false
    existing_vpc_endpoint_id          = null
    add_vpc_cidr_block_project_access = false
  }
}

variable "privatelink_with_managed_vpc_endpoint" {
  type = object({
    enabled            = optional(bool)
    vpc_id             = optional(string)
    subnet_ids         = optional(set(string))
    security_group_ids = optional(set(string))
  })
  default = {
    enabled            = false
    vpc_id             = ""
    subnet_ids         = []
    security_group_ids = []
  }
}
