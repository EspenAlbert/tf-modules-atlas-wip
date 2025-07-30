

resource "mongodbatlas_custom_db_role" "this" {
  dynamic "actions" {
    for_each = var.mongodbatlas_custom_db_role.actions == null ? [] : var.mongodbatlas_custom_db_role.actions
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
    for_each = var.mongodbatlas_custom_db_role.inherited_roles == null ? [] : var.mongodbatlas_custom_db_role.inherited_roles
    content {
      database_name = inherited_roles.value.database_name
      role_name     = inherited_roles.value.role_name
    }
  }
  project_id = var.mongodbatlas_custom_db_role.project_id
  role_name  = var.mongodbatlas_custom_db_role.role_name
}

