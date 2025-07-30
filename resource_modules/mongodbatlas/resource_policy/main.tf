

resource "mongodbatlas_resource_policy" "this" {
  description = var.description
  name        = var.name
  org_id      = var.org_id
  policies    = var.policies
}

