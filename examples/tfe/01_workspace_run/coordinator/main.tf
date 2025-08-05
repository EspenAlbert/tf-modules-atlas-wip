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

  platform_env_vars = merge(local.tfe_config_base, {
    TF_WORKSPACE = var.tfe_workspace_names.platform
  })

  # App workspace variables and env vars  
  app_terraform_variables = merge(var.app_variables, {
    aws_region         = var.aws_region
    tfe_org            = var.tfe_organization
    platform_workspace = var.tfe_workspace_names.platform
  })

  app_env_vars = merge(local.tfe_config_base, {
    TF_WORKSPACE = var.tfe_workspace_names.app
  })
}

resource "tfe_oauth_client" "github" {
  organization     = var.tfe_organization
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.GH_TOKEN
  service_provider = "github"
}

module "platform_workspace" {
  source = "./modules/workspace"

  name              = var.tfe_workspace_names.platform
  organization      = var.tfe_organization
  working_directory = "examples/tfe/01_workspace_run/platform"
  vcs_repo          = local.vcs_repo_config

  terraform_variables = local.platform_terraform_variables
  env_vars            = local.platform_env_vars
  sensitive_env_vars  = var.aws_credentials
}

module "app_workspace" {
  source = "./modules/workspace"

  name              = var.tfe_workspace_names.app
  organization      = var.tfe_organization
  working_directory = "examples/tfe/01_workspace_run/app"
  vcs_repo          = local.vcs_repo_config

  terraform_variables = local.app_terraform_variables
  env_vars            = local.app_env_vars
  sensitive_env_vars  = var.atlas_credentials
}



resource "tfe_workspace_settings" "this" {
  for_each = {
    platform = [module.app_workspace.workspace_id]
    app      = [module.platform_workspace.workspace_id]
  }
  workspace_id              = each.key
  remote_state_consumer_ids = each.value
}
