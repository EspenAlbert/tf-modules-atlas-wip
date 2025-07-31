variable "bucket_name" {
  type = string
}

variable "cloud_provider" {
  type = string
}

variable "project_id" {
  type = string
}

variable "iam_role_id" {
  type     = string
  nullable = true
  default  = null
}

variable "role_id" {
  type     = string
  nullable = true
  default  = null
}

variable "service_url" {
  type     = string
  nullable = true
  default  = null
}
