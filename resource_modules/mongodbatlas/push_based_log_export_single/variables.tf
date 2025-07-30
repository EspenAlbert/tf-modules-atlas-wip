variable "mongodbatlas_push_based_log_export" {
  type = object({
    bucket_name = string
    iam_role_id = string
    prefix_path = optional(string)
    project_id  = string
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  })
}
