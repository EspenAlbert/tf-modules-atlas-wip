module "auth_db" {
  source     = "../../../modules/05_auth_db"
  project_id = module.atlas_project.id
  aws_iam_role_database_users = [
    {
      role_arn = var.aws_iam_role_arn_ec2
      roles = [
        {
          role_name     = "atlasAdmin"
          database_name = "admin"
        }
      ]
    }
  ]
  custom_db_roles = {
    my_custom_role = {
      actions = {
        UPDATE = [
          {
            database_name = "myDb"
          }
        ]
        INSERT = [
          {
            database_name = "myDb"
          }
        ]
        REMOVE = [
          {
            database_name = "myDb"
          }
        ]
      }
    }
  }
}
