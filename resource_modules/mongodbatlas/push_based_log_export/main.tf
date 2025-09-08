

resource "mongodbatlas_push_based_log_export" "this" {
  bucket_name              = var.bucket_name
  delete_on_create_timeout = var.delete_on_create_timeout
  iam_role_id              = var.iam_role_id
  prefix_path              = var.prefix_path
  project_id               = var.project_id
  timeouts                 = var.timeouts
}

