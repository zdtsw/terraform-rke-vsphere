#*************************************************************
#  Windows_Clone VM module  
#*************************************************************
# Input vairables for module
# https://www.terraform.io/docs/configuration/modules.html
# https://www.terraform.io/docs/configuration/variables.html
# *************************************************************

variable "name_prefix" {
  type        = string
  default     = "rke-default-prefix"
  description = "The name of vcentre name to use"
}

variable "vsphere_datacenter" {
  type        = string
  description = "The name of vcentre name to use"
}

variable "vsphere_datastore" {
  type        = string
  description = "Name of the datastore to use"
}

variable "vsphere_compute_cluster" {
  type        = string
  description = "The name of compute resource cluster pool to use"
}

variable "vsphere_network" {
  type        = string
  description = "The name of the network interface to use"
}

variable "vsphere_template" {
  type        = string
  description = "Name of the packer template to be used, can exist anywhere in the datacentre as long as its name is unique"
}

variable "vm_count" {
  type        = string
  default     = "0"
  description = "The quantity of nodes to create using the module, suggested max of less than 15 per datastore"
}

variable "vsphere_folder" {
  type        = string
  description = "folder to store the nodes in, split by datastore ID"
}

variable "ram_count" {
  type        = string
  default     = "32768"
  description = "Amount of Ram to be commisioned for the vm"
}

variable "domain_ou" {
  type        = string
  default     = "DC=ad,DC=mycompany,DC=com"
  description = "Domain Active Directory Organisational Unit being used e.g. ad.mycompany.com"
}

variable "domain_admin" {
  type        = string
  description = "User with access to AD services to move node to correct OU"
}

variable "domain_admin_password" {
  type        = string
  description = "password for the domain user"
}


variable "project_dir" {
  type        = string
  description = "project direcotory of the root gitlab location"
}

variable "disk_size" {
  type        = string
  default     = "250"
  description = "size of the disk required in GB e.g. 250 = 250GB for C:"
}

variable "project_name" {
  type        = string
  default     = "rke-default"
  description = "name of the project being past, needed for provisioning"
}
