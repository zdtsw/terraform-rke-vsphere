
# *************************************************************
# Default Settings to use
# https://www.terraform.io/docs/configuration/variables.html
# *************************************************************
variable "rke_network" {
  default = "Buildfarm (VLAN 1028)"
  description = "Name of the network name to use in datacentre"
}
variable "rke_datacenter" {
  default = "DC"
  description = "The name of vcentre name to use"
}
variable "rke_compute_cluster" {
  default = "RKE"
  description = "Name of the compute cluster to use in datacentre e.g. M630"
}
variable "project_name" {
  default = "rke"
  description = "namer of the project e.g. rke"
}
variable "disk_size" {
  default = "400"
  description = "size of the disk required in GB e.g. 250 = 250GB for C:"
}

variable "packer_template" {
  type        = string
  default = "centos-template-7"
  description = "Packer template for new vms. Existing vms will not be updated"
}

variable "cluster_name" {
  type        = string
  default     = "rke_prod"
  description = "The name of vcentre name to use"
}

variable "domain_ou" {
  type = string
  default = "DC=ad,DC=mycompany,DC=com"
  description = "AD search path"
}

# *************************************************************
# Environmental Settings to use
# https://www.terraform.io/docs/configuration/variables.html
# *************************************************************
variable "vsphere_server" {}

variable "vsphere_user" {}

variable "vsphere_password" {}

variable "domain_password" {}

variable "domain_admin" {}

variable "project_dir" {}

variable "AWS_USER" {}

variable "AWS_PASSWORD" {}

variable "S3_URL" {}

