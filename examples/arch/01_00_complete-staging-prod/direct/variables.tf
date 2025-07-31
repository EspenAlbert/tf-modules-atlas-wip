# source/includes/examples/tf-example-variables.rst
variable "atlas_org_id" {
  type        = string
  description = "Atlas Organization ID"
}

# Atlas Project Name
variable "atlas_project_name" {
  type        = string
  description = "Atlas Project Name"
}

# Atlas Project Environment
variable "environment" {
  type        = string
  description = "The environment to be built"
}

# Cluster Instance Size Name 
variable "cluster_instance_size_name" {
  type        = string
  description = "Cluster instance size name"
}

# Cloud Provider to Host Atlas Cluster
variable "cloud_provider" {
  type        = string
  description = "AWS or GCP or Azure"
}

# Atlas Region
variable "atlas_region" {
  type        = string
  description = "Atlas region where resources will be created"
}

# MongoDB Version 
variable "mongodb_version" {
  type        = string
  description = "MongoDB Version"
}

# Atlas Group Name
variable "atlas_group_name" {
  type        = string
  description = "Atlas Group Name"
}

# source/includes/examples/tf-example-auth-variables-stagingprod.rst
variable "token_audience" {
  type        = string
  default     = "https://management.azure.com/"
  description = "Used as resource when getting the access token. See more in the [Azure documentation](https://learn.microsoft.com/en-us/entra/identity/managed-identities-azure-resources/how-to-use-vm-token#get-a-token-using-http)"
}

# source LOCAL_REPO/resource_modules/mongodbatlas/cloud_provider_access_authorization/variables.tf
variable "azure" {
  type = list(object({
    atlas_azure_app_id   = string
    service_principal_id = string
    tenant_id            = string
  }))
  nullable = true
  default  = null
}
