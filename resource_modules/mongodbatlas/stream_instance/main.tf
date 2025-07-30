

resource "mongodbatlas_stream_instance" "this" {
  data_process_region = var.data_process_region
  instance_name       = var.instance_name
  project_id          = var.project_id
  stream_config       = var.stream_config
}

