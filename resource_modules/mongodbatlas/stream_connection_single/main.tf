

resource "mongodbatlas_stream_connection" "this" {
  authentication     = var.mongodbatlas_stream_connection.authentication
  aws                = var.mongodbatlas_stream_connection.aws
  bootstrap_servers  = var.mongodbatlas_stream_connection.bootstrap_servers
  cluster_name       = var.mongodbatlas_stream_connection.cluster_name
  cluster_project_id = var.mongodbatlas_stream_connection.cluster_project_id
  config             = var.mongodbatlas_stream_connection.config
  connection_name    = var.mongodbatlas_stream_connection.connection_name
  db_role_to_execute = var.mongodbatlas_stream_connection.db_role_to_execute
  headers            = var.mongodbatlas_stream_connection.headers
  instance_name      = var.mongodbatlas_stream_connection.instance_name
  networking         = var.mongodbatlas_stream_connection.networking
  project_id         = var.mongodbatlas_stream_connection.project_id
  security           = var.mongodbatlas_stream_connection.security
  type               = var.mongodbatlas_stream_connection.type
  url                = var.mongodbatlas_stream_connection.url
}

