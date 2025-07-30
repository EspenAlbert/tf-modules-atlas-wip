

resource "mongodbatlas_federated_settings_org_role_mapping" "this" {
  external_group_name    = var.external_group_name
  federation_settings_id = var.federation_settings_id
  org_id                 = var.org_id
  dynamic "role_assignments" {
    for_each = var.role_assignments == null ? [] : var.role_assignments
    content {
      group_id = role_assignments.value.group_id
      org_id   = role_assignments.value.org_id
      roles    = role_assignments.value.roles
    }
  }
}

