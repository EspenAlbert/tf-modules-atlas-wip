

resource "mongodbatlas_push_based_log_export" "this" {
  bucket_name = var.mongodbatlas_push_based_log_export.bucket_name
  iam_role_id = var.mongodbatlas_push_based_log_export.iam_role_id
  prefix_path = var.mongodbatlas_push_based_log_export.prefix_path
  project_id  = var.mongodbatlas_push_based_log_export.project_id
  timeouts    = var.mongodbatlas_push_based_log_export.timeouts
}

