variable "mongodbatlas_custom_dns_configuration_cluster_aws" {
  type = object({
    enabled    = bool
    project_id = string
  })
}
