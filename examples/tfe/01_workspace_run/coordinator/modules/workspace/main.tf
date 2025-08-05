resource "tfe_workspace" "this" {
  name              = var.name
  organization      = var.organization
  working_directory = var.working_directory
  queue_all_runs    = false
  project_id        = var.project_id

  vcs_repo {
    branch         = var.vcs_repo.branch
    identifier     = var.vcs_repo.identifier
    oauth_token_id = var.vcs_repo.oauth_token_id
  }
}

resource "tfe_variable" "terraform_vars" {
  for_each     = var.terraform_variables
  key          = each.key
  value        = each.value
  category     = "terraform"
  sensitive    = false
  workspace_id = tfe_workspace.this.id
}

resource "tfe_variable" "env_vars" {
  for_each     = var.env_vars
  key          = each.key
  value        = each.value
  category     = "env"
  hcl          = false
  sensitive    = false
  workspace_id = tfe_workspace.this.id
}

resource "tfe_variable" "sensitive_env_vars" {
  for_each     = nonsensitive(var.sensitive_env_vars)
  key          = each.key
  value        = each.value
  category     = "env"
  hcl          = false
  sensitive    = true
  workspace_id = tfe_workspace.this.id
}
