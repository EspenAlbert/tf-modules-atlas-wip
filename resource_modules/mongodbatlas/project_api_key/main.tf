

resource "mongodbatlas_project_api_key" "this" {
  description = var.description
  dynamic "project_assignment" {
    for_each = var.project_assignment == null ? [] : var.project_assignment
    content {
      project_id = project_assignment.value.project_id
      role_names = project_assignment.value.role_names
    }
  }
}

