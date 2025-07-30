

resource "mongodbatlas_federated_query_limit" "this" {
  default_limit  = var.mongodbatlas_federated_query_limit.default_limit
  limit_name     = var.mongodbatlas_federated_query_limit.limit_name
  maximum_limit  = var.mongodbatlas_federated_query_limit.maximum_limit
  overrun_policy = var.mongodbatlas_federated_query_limit.overrun_policy
  project_id     = var.mongodbatlas_federated_query_limit.project_id
  tenant_name    = var.mongodbatlas_federated_query_limit.tenant_name
  value          = var.mongodbatlas_federated_query_limit.value
}

