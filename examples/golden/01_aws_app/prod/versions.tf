
terraform {
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.26"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    local = { # used to write the .env file
      source  = "hashicorp/local"
      version = "2.4.1"
    }
  }
  required_version = ">= 1.8"
}
