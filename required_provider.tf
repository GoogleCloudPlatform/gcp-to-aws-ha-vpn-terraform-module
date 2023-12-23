terraform {
  required_version = "~> 1.6"
  required_providers {
    google = {
      source  = "hashicorp/google",
      version = "~> 5.10"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31"
    }
  }
}