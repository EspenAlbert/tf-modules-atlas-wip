variable "project_id" {
  type = string
}
variable "existing_bucket_arn" {
  type        = string
  description = "Existing S3 bucket ARN"
  default     = ""
  nullable    = false
}

variable "atlas_role_id" {
  type        = string
  description = "Atlas Cloud Provider role ID"
}

variable "prefix_path" {
  type        = string
  description = "Prefix path for the push-based log export"
  default     = "push-based-log-test"
}

variable "create_s3_bucket" {
  type        = bool
  description = "Create a new S3 bucket"
  default     = false
}
variable "bucket_name" {
  type        = string
  description = "S3 bucket name, use this to create a new bucket"
  default     = ""
  nullable    = false
}

variable "existing_aws_iam_role_arn" {
  type        = string
  description = "Existing AWS IAM role ARN"
}

variable "bucket_policy_name" {
  type        = string
  description = "Name of the S3 bucket policy"
  default     = "AtlasPushBasedLogPolicy"
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    update = optional(string)
  })
  nullable = true
  default  = null
}
