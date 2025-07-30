

resource "mongodbatlas_custom_dns_configuration_cluster_aws" "this" {
  enabled    = var.mongodbatlas_custom_dns_configuration_cluster_aws.enabled
  project_id = var.mongodbatlas_custom_dns_configuration_cluster_aws.project_id
}

