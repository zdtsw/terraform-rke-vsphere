terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">=2.0.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">=3.0.0"
    }
    rke = {
      source  = "rancher/rke"
      version = ">=1.1.6"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
  required_version = ">= 0.13.4"
}


