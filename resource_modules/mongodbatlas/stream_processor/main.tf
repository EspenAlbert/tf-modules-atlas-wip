

resource "mongodbatlas_stream_processor" "this" {
  instance_name  = var.instance_name
  options        = var.options
  pipeline       = var.pipeline
  processor_name = var.processor_name
  project_id     = var.project_id
  state          = var.state
}

