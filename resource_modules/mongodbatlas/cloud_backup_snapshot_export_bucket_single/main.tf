

resource "mongodbatlas_cloud_backup_snapshot_export_bucket" "this" {
  bucket_name    = var.mongodbatlas_cloud_backup_snapshot_export_bucket.bucket_name
  cloud_provider = var.mongodbatlas_cloud_backup_snapshot_export_bucket.cloud_provider
  iam_role_id    = var.mongodbatlas_cloud_backup_snapshot_export_bucket.iam_role_id
  project_id     = var.mongodbatlas_cloud_backup_snapshot_export_bucket.project_id
  role_id        = var.mongodbatlas_cloud_backup_snapshot_export_bucket.role_id
  service_url    = var.mongodbatlas_cloud_backup_snapshot_export_bucket.service_url
}

