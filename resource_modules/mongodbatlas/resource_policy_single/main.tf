

resource "mongodbatlas_resource_policy" "this" {
  description = var.mongodbatlas_resource_policy.description
  name        = var.mongodbatlas_resource_policy.name
  org_id      = var.mongodbatlas_resource_policy.org_id
  policies    = var.mongodbatlas_resource_policy.policies
}

