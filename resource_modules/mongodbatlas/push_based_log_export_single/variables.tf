variable "mongodbatlas_push_based_log_export" {
  type = object({
    bucket_name              = string
    delete_on_create_timeout = optional(bool)
    iam_role_id              = string
    prefix_path              = optional(string)
    project_id               = string
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  })
}
