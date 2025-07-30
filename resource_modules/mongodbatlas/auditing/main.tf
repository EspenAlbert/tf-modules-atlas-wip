

resource "mongodbatlas_auditing" "this" {
  audit_authorization_success = var.audit_authorization_success
  audit_filter                = var.audit_filter
  enabled                     = var.enabled
  project_id                  = var.project_id
}

