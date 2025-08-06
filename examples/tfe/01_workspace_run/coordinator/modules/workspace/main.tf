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

resource "tfe_variable" "terraform_sensitive_vars" {
  for_each     = nonsensitive(var.terraform_sensitive_variables) # Keys are not sensitive, but values are
  key          = each.key
  value        = each.value
  category     = "terraform"
  sensitive    = true
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

# ideally these would be created per project/org and used as a `tfe_variable_set, but for this example we keep the standalone per workspace
resource "tfe_variable" "sensitive_env_vars" {
  for_each     = nonsensitive(var.sensitive_env_vars) # Keys are not sensitive, but values are
  key          = each.key
  value        = each.value
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.this.id
}
