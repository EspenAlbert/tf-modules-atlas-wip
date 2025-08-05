
terraform {
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.26"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.68.2"
    }
  }
  required_version = ">= 1.8"

  cloud {
    workspaces {
      name = "vcs-app"
    }
  }
}
