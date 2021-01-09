locals {
  master_settings = {
    "master"      = { rke_datastore="DS2", vm_count="3", name_prefix ="${var.cluster_name}-master"}
  }
  worker_settings = {
    "worker"      = { rke_datastore="DS3", vm_count="5", name_prefix ="${var.cluster_name}-worker"}
  }
}

module "master" {
  source                         = "../../modules/node"

  for_each                       = local.master_settings
  vsphere_datastore              = each.value.rke_datastore
  vm_count                       = each.value.vm_count
  name_prefix                    = each.value.name_prefix

  vsphere_template               = var.packer_template
  vsphere_network                = var.rke_network
  vsphere_compute_cluster        = var.rke_compute_cluster
  vsphere_datacenter             = var.rke_datacenter
  vsphere_folder                 = "terraform-nodes/${var.cluster_name}-master"
  domain_admin                   = var.domain_admin
  domain_admin_password          = var.domain_password
  domain_ou                      = var.domain_ou
  project_dir                    = var.project_dir
  project_name                   = var.project_name
  disk_size                      = var.disk_size
}

module "worker" {
  source                         = "../../modules/node"

  for_each                       = local.worker_settings
  vsphere_datastore              = each.value.rke_datastore
  vm_count                       = each.value.vm_count
  name_prefix                    = each.value.name_prefix

  vsphere_template               = var.packer_template
  vsphere_network                = var.rke_network
  vsphere_compute_cluster        = var.rke_compute_cluster
  vsphere_datacenter             = var.rke_datacenter
  vsphere_folder                 = "terraform-nodes/${var.cluster_name}-worker"
  domain_admin                   = var.domain_admin
  domain_admin_password          = var.domain_password
  domain_ou                      = var.domain_ou
  project_dir                    = var.project_dir
  project_name                   = var.project_name
  disk_size                      = var.disk_size
}

module "rke" {
  source            = "../../modules/rke"

  system_user       = var.system_user
  ssh_key_file      = var.ssh_key_file
  use_ssh_agent     = var.use_ssh_agent
  wait_for_commands = var.wait_for_commands
  cluster_name      = var.cluster_name

  master_depends_on = module.master["master"].nodes
  master_nodes      = module.master["master"].nodes
  master_labels     = var.master_labels

  worker_depends_on = module.worker["worker"].nodes
  worker_nodes      = module.worker["worker"].nodes
  worker_labels     = var.worker_labels

  k8s_version       = var.kubernetes_version

  mtu               = var.cni_mtu
  plugin            = var.cni_plugin

  deploy_nginx      = var.deploy_nginx
  
  cloud_provider    = var.cloud_provider
  write_kubeconfig  = var.write_kubeconfig
}