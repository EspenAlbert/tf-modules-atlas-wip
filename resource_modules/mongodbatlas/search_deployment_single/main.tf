

resource "mongodbatlas_search_deployment" "this" {
  cluster_name             = var.mongodbatlas_search_deployment.cluster_name
  delete_on_create_timeout = var.mongodbatlas_search_deployment.delete_on_create_timeout
  project_id               = var.mongodbatlas_search_deployment.project_id
  skip_wait_on_update      = var.mongodbatlas_search_deployment.skip_wait_on_update
  specs                    = var.mongodbatlas_search_deployment.specs
  timeouts                 = var.mongodbatlas_search_deployment.timeouts
}

