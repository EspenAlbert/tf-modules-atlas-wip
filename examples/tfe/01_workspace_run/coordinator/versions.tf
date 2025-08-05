
terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.68.2"
    }
  }
  required_version = ">= 1.8"

  cloud {
    workspaces {
      name = "ex-coordinator"
    }
  }
}
