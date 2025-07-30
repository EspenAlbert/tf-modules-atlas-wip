

resource "mongodbatlas_access_list_api_key" "this" {
  api_key_id = var.api_key_id
  cidr_block = var.cidr_block
  ip_address = var.ip_address
  org_id     = var.org_id
}

