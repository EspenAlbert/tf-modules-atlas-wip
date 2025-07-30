variable "mongodbatlas_encryption_at_rest_private_endpoint" {
  type = object({
    cloud_provider = string
    project_id     = string
    region_name    = string
  })
}
