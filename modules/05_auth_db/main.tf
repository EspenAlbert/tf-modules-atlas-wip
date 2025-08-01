

resource "mongodbatlas_database_user" "aws_iam_roles" {
  for_each = { for user in var.aws_iam_role_database_users : user.role_arn => user }

  auth_database_name = "$external"
  aws_iam_type       = "ROLE"
  description        = each.value.description
  dynamic "labels" {
    for_each = each.value.labels == null ? [] : each.value.labels
    content {
      key   = labels.value.key
      value = labels.value.value
    }
  }
  project_id = var.project_id
  dynamic "roles" {
    for_each = each.value.roles
    content {
      collection_name = roles.value.collection_name
      database_name   = roles.value.database_name
      role_name       = roles.value.role_name
    }
  }
  dynamic "scopes" {
    for_each = each.value.scopes == null ? [] : each.value.scopes
    content {
      name = scopes.value.name
      type = scopes.value.type
    }
  }
  username = each.value.role_arn
}



resource "mongodbatlas_custom_db_role" "this" {
  for_each = var.custom_db_roles

  project_id = var.project_id
  role_name  = each.key

  dynamic "actions" {
    for_each = each.value.actions == null ? tomap({}) : each.value.actions

    content {
      action = actions.key

      dynamic "resources" {
        for_each = actions.value

        content {
          cluster         = resources.value.cluster
          collection_name = resources.value.collection_name
          database_name   = resources.value.database_name
        }
      }
    }
  }
  dynamic "inherited_roles" {
    for_each = each.value.inherited_roles == null ? [] : each.value.inherited_roles
    content {
      database_name = inherited_roles.value.database_name
      role_name     = inherited_roles.value.role_name
    }
  }
}
