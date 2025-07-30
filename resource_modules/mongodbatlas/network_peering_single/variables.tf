variable "mongodbatlas_network_peering" {
  type = object({
    accepter_region_name   = optional(string)
    atlas_cidr_block       = optional(string)
    atlas_gcp_project_id   = optional(string)
    atlas_vpc_name         = optional(string)
    aws_account_id         = optional(string)
    azure_directory_id     = optional(string)
    azure_subscription_id  = optional(string)
    container_id           = string
    gcp_project_id         = optional(string)
    network_name           = optional(string)
    project_id             = string
    provider_name          = string
    resource_group_name    = optional(string)
    route_table_cidr_block = optional(string)
    vnet_name              = optional(string)
    vpc_id                 = optional(string)
  })
}
