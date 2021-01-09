# *************************************************************
terraform {
    backend "artifactory" {
        repo     = "dreeu-generic-local"
        subpath  = "terraform-state/v13/rke_dev"
    }
}

#*************************************************************
#  Sets up the initial needs to provide a vsphere instance
#*************************************************************
# Point to our provider
# https://www.terraform.io/docs/providers/vsphere/index.html
# *************************************************************

provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}
