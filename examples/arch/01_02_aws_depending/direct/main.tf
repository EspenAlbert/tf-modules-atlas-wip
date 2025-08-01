resource "mongodbatlas_cloud_provider_access_setup" "this" {
  project_id    = var.atlas_project_id
  provider_name = "AWS"
}

# AWS ONLY- remove for other cloud providers: Enable BYOK encryption
# For IAM roles and Azure assigned identities, you must create the 
# role or identity and declare the variable before you use this 
# Terraform resource
resource "mongodbatlas_cloud_provider_access_authorization" "this" {
  project_id = var.atlas_project_id
  role_id    = mongodbatlas_cloud_provider_access_setup.this.role_id

  aws {
    iam_assumed_role_arn = aws_iam_role.this.arn
  }
}

# For KMS keys, you must create the 
# key and declare the variable before you use this 
# Terraform resource
resource "mongodbatlas_encryption_at_rest" "this" {
  project_id = var.atlas_project_id

  aws_kms_config {
    enabled                = true
    customer_master_key_id = aws_kms_key.this.id
    region                 = var.atlas_region
    role_id                = mongodbatlas_cloud_provider_access_authorization.this.role_id
  }
}
