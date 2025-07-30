

resource "mongodbatlas_project_api_key" "this" {
  description = var.mongodbatlas_project_api_key.description
  dynamic "project_assignment" {
    for_each = var.mongodbatlas_project_api_key.project_assignment == null ? [] : var.mongodbatlas_project_api_key.project_assignment
    content {
      project_id = project_assignment.value.project_id
      role_names = project_assignment.value.role_names
    }
  }
}

