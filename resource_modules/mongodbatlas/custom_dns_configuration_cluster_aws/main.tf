

resource "mongodbatlas_custom_dns_configuration_cluster_aws" "this" {
  enabled    = var.enabled
  project_id = var.project_id
}

