
terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.68.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.8"
  cloud {
    organization = "mongodb-professional-services"

    workspaces {
      name    = "ex-platform"
      project = "espen"
    }
  }
}
