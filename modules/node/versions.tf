terraform {
  required_version = ">= 0.13"
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "= 3.0.0"
    }
    vsphere = {
      source = "hashicorp/vsphere"
      version = "= 1.24.3"
    }
  }
}
