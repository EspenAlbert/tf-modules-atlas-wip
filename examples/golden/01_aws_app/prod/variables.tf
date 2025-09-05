variable "atlas_org_id" {
  type        = string
  description = "Atlas Organization ID"
}

variable "atlas_project_name" {
  type        = string
  description = "Atlas Project Name"
}

variable "cluster_name" {
  type        = string
  description = "Cluster name"
}

variable "atlas_region" {
  type        = string
  description = "Atlas region where resources will be created"
}

variable "aws_iam_role_name" {
  type        = string
  description = "Created to be used by the atlas cloud provider"
}

# AWS VPC config
variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "aws_iam_role_app_name" {
  type = string
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the resources"
  default     = {}
}

# AWS S3 Bucket For Log Export
variable "log_bucket_name" {
  type        = string
  description = "AWS S3 Bucket Name For Log Export"
}

# DUMP For APP .env file
variable "api_mongo_env_path" {
  type        = string
  description = "Add a path to the api-mongo .env file"
  default     = ""
}
