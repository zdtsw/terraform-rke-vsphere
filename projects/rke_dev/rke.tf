#################
# RKE variables #
#################

variable "system_user" {
  type        = string
  default     = "centos"
  description = "Default OS image user"
}

variable "use_ssh_agent" {
  type        = bool
  default     = "true"
  description = "Whether to use ssh agent"
}

variable "ssh_key_file" {
  type        = string
  default     = "~/.ssh/id_rsa_centos"
  description = "Local path to SSH key"
}

variable "wait_for_commands" {
  type        = list(string)
  default     = ["uname"]
  description = "Commands to run on nodes before running RKE"
}

variable "master_labels" {
  type        = map(string)
  default     = { 
      "node-role.kubernetes.io/master" = "true"
      "kubernetes.io/os" = "linux"
   }
  description = "Master labels"
}

variable "worker_labels" {
  type        = map(string)
  default     = { 
    "node-role.kubernetes.io/worker" = "true"
    "kubernetes.io/os" = "linux"
  }
  description = "Worker labels"
}

variable "kubernetes_version" {
  type        = string
  default     = "v1.19.6-rancher1-1"
  description = "Kubernetes version (RKE)"
}

variable "cni_mtu" {
  type        = number
  default     = 0
  description = "CNI MTU"
}

variable "cni_plugin" {
  type        = string
  default     = "calico"
  description = "CNI plugin"
}

variable "deploy_nginx" {
  type        = bool
  default     = "true"
  description = "Whether to deploy nginx RKE addon"
}

variable "cloud_provider" {
  type        = string
  default     = "vsphere"   # vsphere||aws||others
  description = "Deploy cloud provider"
}

variable "default_storage" {
  type        = string
  default     = "vsphere-csi" # need to to map what your stroageclass's name
  description = "Default storage class"
}

variable "addons_include" {
  type        = list(string)
  default     = null
  description = "RKE YAML files for add-ons"
}

variable "write_kubeconfig" {
  type        = bool
  default     = "true"
  description = "Write kubeconfig file to disk"
}