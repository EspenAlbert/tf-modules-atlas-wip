variable "project_id" {
  type = string
}

variable "atlas_region" {
  type = string
}

variable "atlas_role_id" {
  type = string
}

variable "aws_iam_role_policy_name" {
  type    = string
  default = "AtlasEncryptionAtRestPolicy"
}

variable "existing_aws_iam_role_arn" {
  type = string
}

variable "require_private_networking" {
  type    = bool
  default = true
}

variable "enable_private_endpoint" {
  type    = bool
  default = true
}

variable "enabled_for_search_nodes" {
  type    = bool
  default = true
}

variable "aws_kms_key_id" {
  type = string
}
