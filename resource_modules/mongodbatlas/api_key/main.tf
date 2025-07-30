

resource "mongodbatlas_api_key" "this" {
  description = var.description
  org_id      = var.org_id
  role_names  = var.role_names
}

