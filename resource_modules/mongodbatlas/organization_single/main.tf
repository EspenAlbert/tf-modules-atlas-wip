

resource "mongodbatlas_organization" "this" {
  api_access_list_required     = var.mongodbatlas_organization.api_access_list_required
  description                  = var.mongodbatlas_organization.description
  federation_settings_id       = var.mongodbatlas_organization.federation_settings_id
  gen_ai_features_enabled      = var.mongodbatlas_organization.gen_ai_features_enabled
  multi_factor_auth_required   = var.mongodbatlas_organization.multi_factor_auth_required
  name                         = var.mongodbatlas_organization.name
  org_owner_id                 = var.mongodbatlas_organization.org_owner_id
  restrict_employee_access     = var.mongodbatlas_organization.restrict_employee_access
  role_names                   = var.mongodbatlas_organization.role_names
  security_contact             = var.mongodbatlas_organization.security_contact
  skip_default_alerts_settings = var.mongodbatlas_organization.skip_default_alerts_settings
}

