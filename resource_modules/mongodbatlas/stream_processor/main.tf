

resource "mongodbatlas_stream_processor" "this" {
  delete_on_create_timeout = var.delete_on_create_timeout
  instance_name            = var.instance_name
  options                  = var.options
  pipeline                 = var.pipeline
  processor_name           = var.processor_name
  project_id               = var.project_id
  state                    = var.state
  timeouts                 = var.timeouts
}

