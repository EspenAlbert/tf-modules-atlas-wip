

resource "mongodbatlas_organization" "this" {
  api_access_list_required     = var.api_access_list_required
  description                  = var.description
  federation_settings_id       = var.federation_settings_id
  gen_ai_features_enabled      = var.gen_ai_features_enabled
  multi_factor_auth_required   = var.multi_factor_auth_required
  name                         = var.name
  org_owner_id                 = var.org_owner_id
  restrict_employee_access     = var.restrict_employee_access
  role_names                   = var.role_names
  security_contact             = var.security_contact
  skip_default_alerts_settings = var.skip_default_alerts_settings
}

