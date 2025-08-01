

resource "mongodbatlas_stream_processor" "this" {
  instance_name  = var.mongodbatlas_stream_processor.instance_name
  options        = var.mongodbatlas_stream_processor.options
  pipeline       = var.mongodbatlas_stream_processor.pipeline
  processor_name = var.mongodbatlas_stream_processor.processor_name
  project_id     = var.mongodbatlas_stream_processor.project_id
  state          = var.mongodbatlas_stream_processor.state
}

