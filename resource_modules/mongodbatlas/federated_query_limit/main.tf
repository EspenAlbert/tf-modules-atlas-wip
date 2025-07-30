

resource "mongodbatlas_federated_query_limit" "this" {
  default_limit  = var.default_limit
  limit_name     = var.limit_name
  maximum_limit  = var.maximum_limit
  overrun_policy = var.overrun_policy
  project_id     = var.project_id
  tenant_name    = var.tenant_name
  value          = var.value
}

