

resource "mongodbatlas_access_list_api_key" "this" {
  api_key_id = var.mongodbatlas_access_list_api_key.api_key_id
  cidr_block = var.mongodbatlas_access_list_api_key.cidr_block
  ip_address = var.mongodbatlas_access_list_api_key.ip_address
  org_id     = var.mongodbatlas_access_list_api_key.org_id
}

