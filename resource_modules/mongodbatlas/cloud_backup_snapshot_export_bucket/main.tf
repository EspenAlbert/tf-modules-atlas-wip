

resource "mongodbatlas_cloud_backup_snapshot_export_bucket" "this" {
  bucket_name    = var.bucket_name
  cloud_provider = var.cloud_provider
  iam_role_id    = var.iam_role_id
  project_id     = var.project_id
  role_id        = var.role_id
  service_url    = var.service_url
}

