locals {
  vcs_repo_config = {
    branch         = var.branch
    identifier     = var.vcs_repo
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }

  tfe_config_base = {
    TF_CLOUD_ORGANIZATION = var.tfe_organization
    TF_CLOUD_PROJECT      = var.tfe_workspace_names.project
  }

  # Platform workspace variables and env vars
  platform_terraform_variables = merge(var.platform_variables, {
    aws_region    = var.aws_region
    tfe_org       = var.tfe_organization
    app_workspace = var.tfe_workspace_names.app
  })

  # App workspace variables and env vars  
  app_terraform_variables = merge(var.app_variables, {
    aws_region         = var.aws_region
    tfe_org            = var.tfe_organization
    platform_workspace = var.tfe_workspace_names.platform
  })
}

resource "tfe_oauth_client" "github" {
  organization     = var.tfe_organization
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.GH_TOKEN
  service_provider = "github"
}

data "tfe_project" "this" {
  organization = var.tfe_organization
  name         = var.tfe_workspace_names.project
}


module "platform_workspace" {
  source = "./modules/workspace"

  name              = var.tfe_workspace_names.platform
  organization      = var.tfe_organization
  working_directory = "examples/tfe/01_workspace_run/platform"
  vcs_repo          = local.vcs_repo_config

  terraform_variables = local.platform_terraform_variables
  env_vars            = local.tfe_config_base
  sensitive_env_vars  = var.aws_credentials
  project_id          = data.tfe_project.this.id
}

module "app_workspace" {
  source = "./modules/workspace"

  name              = var.tfe_workspace_names.app
  organization      = var.tfe_organization
  working_directory = "examples/tfe/01_workspace_run/app"
  vcs_repo          = local.vcs_repo_config

  terraform_variables = local.app_terraform_variables
  env_vars            = local.tfe_config_base
  sensitive_env_vars  = var.atlas_credentials
  project_id          = data.tfe_project.this.id
}



resource "tfe_workspace_settings" "this" {
  for_each = {
    platform = {
      workspace_id              = module.app_workspace.workspace_id
      remote_state_consumer_ids = [module.platform_workspace.workspace_id]
    }
    app = {
      workspace_id              = module.platform_workspace.workspace_id
      remote_state_consumer_ids = [module.app_workspace.workspace_id]
    }
  }
  workspace_id              = each.value.workspace_id
  remote_state_consumer_ids = each.value.remote_state_consumer_ids
}
