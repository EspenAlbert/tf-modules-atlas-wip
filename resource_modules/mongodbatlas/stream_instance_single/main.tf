

resource "mongodbatlas_stream_instance" "this" {
  data_process_region = var.mongodbatlas_stream_instance.data_process_region
  instance_name       = var.mongodbatlas_stream_instance.instance_name
  project_id          = var.mongodbatlas_stream_instance.project_id
  stream_config       = var.mongodbatlas_stream_instance.stream_config
}

