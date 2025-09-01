resource "mongodbatlas_auditing" "this" {
  count = var.auditing_enabled ? 1 : 0

  audit_authorization_success = var.auditing.audit_authorization_success
  audit_filter                = var.auditing.audit_filter
  enabled                     = true
  project_id                  = mongodbatlas_project.this.id
}
