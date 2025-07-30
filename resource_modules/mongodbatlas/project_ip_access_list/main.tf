

resource "mongodbatlas_project_ip_access_list" "this" {
  aws_security_group = var.aws_security_group
  cidr_block         = var.cidr_block
  comment            = var.comment
  ip_address         = var.ip_address
  project_id         = var.project_id
  timeouts           = var.timeouts
}

