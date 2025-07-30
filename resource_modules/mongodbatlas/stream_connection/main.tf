

resource "mongodbatlas_stream_connection" "this" {
  authentication     = var.authentication
  aws                = var.aws
  bootstrap_servers  = var.bootstrap_servers
  cluster_name       = var.cluster_name
  cluster_project_id = var.cluster_project_id
  config             = var.config
  connection_name    = var.connection_name
  db_role_to_execute = var.db_role_to_execute
  headers            = var.headers
  instance_name      = var.instance_name
  networking         = var.networking
  project_id         = var.project_id
  security           = var.security
  type               = var.type
  url                = var.url
}

