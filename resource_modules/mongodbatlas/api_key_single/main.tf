

resource "mongodbatlas_api_key" "this" {
  description = var.mongodbatlas_api_key.description
  org_id      = var.mongodbatlas_api_key.org_id
  role_names  = var.mongodbatlas_api_key.role_names
}

