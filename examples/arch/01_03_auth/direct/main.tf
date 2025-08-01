# resource "mongodbatlas_database_user" "oidc" { #TODO: Add OIDC user example later
#   project_id         = var.project_id
#   username           = "${mongodbatlas_federated_settings_identity_provider.oidc.idp_id}/${azurerm_user_assigned_identity.this.principal_id}"
#   oidc_auth_type     = "USER"
#   auth_database_name = "$external" # required when using OIDC USER authentication

#   roles {
#     role_name     = "atlasAdmin"
#     database_name = "admin"
#   }
# }


resource "mongodbatlas_database_user" "aws_role" {
  auth_database_name = "$external"
  project_id         = var.atlas_project_id
  username           = var.aws_iam_role_arn
  aws_iam_type       = "ROLE"

  roles {
    role_name     = "atlasAdmin"
    database_name = "admin"
  }
}

# Configure a custom role
resource "mongodbatlas_custom_db_role" "this" {
  project_id = var.atlas_project_id
  role_name  = "my_custom_role"

  actions {
    action = "UPDATE"
    resources {
      database_name = "myDb"
    }
  }
  actions {
    action = "INSERT"
    resources {
      database_name = "myDb"
    }
  }
  actions {
    action = "REMOVE"
    resources {
      database_name = "myDb"
    }
  }
}
