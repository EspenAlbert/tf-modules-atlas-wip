variable "mongodbatlas_network_container" {
  type = object({
    atlas_cidr_block = string
    project_id       = string
    provider_name    = optional(string)
    region           = optional(string)
    region_name      = optional(string)
    regions          = optional(list(string))
  })
}
