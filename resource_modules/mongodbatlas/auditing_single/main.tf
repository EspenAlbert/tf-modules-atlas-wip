

resource "mongodbatlas_auditing" "this" {
  audit_authorization_success = var.mongodbatlas_auditing.audit_authorization_success
  audit_filter                = var.mongodbatlas_auditing.audit_filter
  enabled                     = var.mongodbatlas_auditing.enabled
  project_id                  = var.mongodbatlas_auditing.project_id
}

