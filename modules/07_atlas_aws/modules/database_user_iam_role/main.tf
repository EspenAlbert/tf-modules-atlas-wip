resource "mongodbatlas_database_user" "aws_iam_role" {
  auth_database_name = "$external"
  aws_iam_type       = "ROLE"
  project_id         = var.project_id
  description        = var.description
  username           = var.existing_role_arn

  dynamic "labels" {
    for_each = var.labels == null ? {} : var.labels
    content {
      key   = labels.value.key
      value = labels.value.value
    }
  }

  dynamic "roles" {
    for_each = var.roles
    content {
      collection_name = roles.value.collection_name
      database_name   = roles.value.database_name
      role_name       = roles.value.role_name
    }
  }

  dynamic "scopes" {
    for_each = var.scopes == null ? [] : var.scopes
    content {
      name = scopes.value.name
      type = scopes.value.type
    }
  }
}
