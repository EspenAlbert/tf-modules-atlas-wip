locals {
  platform_variables = merge(var.platform_variables, {
    aws_region = var.aws_region
    tfe_org = var.tfe_organization
    app_workspace = tfe_workspace.app.name
  })
  app_variables = merge(var.app_variables, {
    aws_region = var.aws_region
    tfe_org = var.tfe_organization
    platform_workspace = tfe_workspace.platform.name
  })
  tfe_config_base = {
    TF_CLOUD_ORGANIZATION = var.tfe_organization
    TF_CLOUD_PROJECT = var.tfe_workspace_names.project
  }
  tfe_config_app = merge(local.tfe_config_base, {
    TF_WORKSPACE = tfe_workspace.app.name
  })
  tfe_config_platform = merge(local.tfe_config_base, {
    TF_WORKSPACE = tfe_workspace.platform.name
  })
}

resource "tfe_oauth_client" "github" {
  organization     = var.tfe_organization
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.GH_TOKEN
  service_provider = "github"
}

resource "tfe_workspace" "platform" {
  name              = var.tfe_workspace_names.platform
  organization      = var.tfe_organization
  queue_all_runs    = false
  working_directory = "examples/tfe/01_workspace_run/platform"

  vcs_repo {
    branch         = var.branch
    identifier     = var.vcp_repo
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
  }
}

resource "tfe_workspace" "app" {
  name              = var.tfe_workspace_names.app
  organization      = var.tfe_organization
  queue_all_runs    = false
  working_directory = "examples/tfe/01_workspace_run/app"

  vcs_repo {
    branch         = var.branch
    identifier     = var.vcp_repo
    oauth_token_id = tfe_oauth_client.github.oauth_token_id

  }
}

resource "tfe_variable" "platform_vars" {
    for_each = local.platform_variables
    key = each.key
    value = each.value
    category = "terraform"
    hcl = false
    sensitive = false
    workspace_id = tfe_workspace.platform.id
}

resource "tfe_variable" "app_vars" {
    for_each = local.app_variables
    key = each.key
    value = each.value
    category = "terraform"
    hcl = false
    sensitive = false
    workspace_id = tfe_workspace.app.id
}

resource "tfe_variable" "atlas_credentials" {
    for_each = var.atlas_credentials
    key = each.key
    value = each.value
    category = "env"
    hcl = false
    sensitive = true
    workspace_id = tfe_workspace.app.id
}

resource "tfe_variable" "aws_credentials" {
    for_each = var.aws_credentials
    key = each.key
    value = each.value
    category = "env"
    hcl = false
    sensitive = true
    workspace_id = tfe_workspace.platform.id
}

resource "tfe_variable" "tfe_config_app" {
    for_each = local.tfe_config_app
    key = each.key
    value = each.value
    category = "env"
    hcl = false
    sensitive = false
    workspace_id = tfe_workspace.app.id
}

resource "tfe_variable" "tfe_config_platform" {
    for_each = local.tfe_config_platform
    key = each.key
    value = each.value
    category = "env"
    hcl = false
    sensitive = false
    workspace_id = tfe_workspace.platform.id
}

resource "tfe_workspace_settings" "output_access" {
  for_each                  = {
    app = tfe_workspace.app.id
    platform = tfe_workspace.platform.id
  }
  workspace_id              = each.value
  global_remote_state       = false
  remote_state_consumer_ids = toset([each.value])
}
