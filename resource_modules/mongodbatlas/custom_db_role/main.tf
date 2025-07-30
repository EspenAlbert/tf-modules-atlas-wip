

resource "mongodbatlas_custom_db_role" "this" {
  dynamic "actions" {
    for_each = var.actions == null ? [] : var.actions
    content {
      action = actions.value.action
      dynamic "resources" {
        for_each = actions.value.resources == null ? [] : actions.value.resources
        content {
          cluster         = resources.value.cluster
          collection_name = resources.value.collection_name
          database_name   = resources.value.database_name
        }
      }
    }
  }
  dynamic "inherited_roles" {
    for_each = var.inherited_roles == null ? [] : var.inherited_roles
    content {
      database_name = inherited_roles.value.database_name
      role_name     = inherited_roles.value.role_name
    }
  }
  project_id = var.project_id
  role_name  = var.role_name
}

