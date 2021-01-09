variable "master_depends_on" {}
variable "master_nodes" {}

variable "worker_depends_on" {}
variable "worker_nodes" {}

variable "cluster_name" {
  type = string
}

variable "system_user" {
  type = string
}

variable "ssh_key_file" {
  type = string
}

variable "use_ssh_agent" {
  type    = bool
  default = "true"
}

variable "wait_for_commands" {
  type = list(string)
}

variable "master_labels" {
  type = map(string)
  default = { "node-role.kubernetes.io/master" = "true" }
}

variable "worker_labels" {
  type = map(string)
  default = { "node-role.kubernetes.io/worker" = "true" }
}

variable "k8s_version" {
  type = string
}

variable "mtu" {
  type    = number
  default = 0
}

variable "plugin" {
  type    = string
  default = "canal"
}

variable "deploy_nginx" {
  type = bool
}

variable "cloud_provider" {
  type = string
}

variable "write_kubeconfig" {
  type = bool
}
