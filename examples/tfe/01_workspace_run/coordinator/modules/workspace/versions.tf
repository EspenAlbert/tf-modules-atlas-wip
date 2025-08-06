terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.68.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.13.0"
    }
  }
  required_version = ">= 1.0"
}
