

resource "mongodbatlas_project_ip_access_list" "this" {
  aws_security_group = var.mongodbatlas_project_ip_access_list.aws_security_group
  cidr_block         = var.mongodbatlas_project_ip_access_list.cidr_block
  comment            = var.mongodbatlas_project_ip_access_list.comment
  ip_address         = var.mongodbatlas_project_ip_access_list.ip_address
  project_id         = var.mongodbatlas_project_ip_access_list.project_id
  timeouts           = var.mongodbatlas_project_ip_access_list.timeouts
}

