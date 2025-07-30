

resource "mongodbatlas_flex_cluster" "this" {
  name                           = var.name
  project_id                     = var.project_id
  provider_settings              = var.provider_settings
  tags                           = var.tags
  termination_protection_enabled = var.termination_protection_enabled
}

