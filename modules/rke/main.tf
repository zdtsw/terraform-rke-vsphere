/* 
  Config and test when master nodes are created
*/
resource "null_resource" "wait_for_master_ssh" {
  depends_on   = [var.master_depends_on]

  for_each         = {
    for index, ip in var.master_nodes: index => ip
  }
  connection {
    host        = each.value
    user        = var.system_user
    private_key = var.use_ssh_agent ? null : file(var.ssh_key_file)
    agent       = var.use_ssh_agent
  }

  provisioner "remote-exec" {
    inline = var.wait_for_commands
  }
}

/* 
  Config and test when worker nodes are created
*/
resource "null_resource" "wait_for_worker_ssh" {
  depends_on   = [var.worker_depends_on]
  
  for_each         = {
    for index, ip in var.worker_nodes: index => ip
  }
  connection {
    host         = each.value
    user         = var.system_user
    private_key  = var.use_ssh_agent ? null : file(var.ssh_key_file)
    agent        = var.use_ssh_agent
  }

  provisioner "remote-exec" {
    inline = var.wait_for_commands
  }
}


resource "rke_cluster" "cluster" {
  depends_on   = [null_resource.wait_for_master_ssh, null_resource.wait_for_worker_ssh]
  cluster_name = var.cluster_name
/*
  dynamic "nodes" {
    
    for_each         = {
      for index, ip in var.master_nodes: index => ip
    }
    
    content {
      # internal_address  = each.value.ip
      address           = nodes.value
      user              = var.system_user
      role              = ["controlplane", "etcd"]
      labels            = var.master_labels
    }
  }
*/

  dynamic "nodes" {
    for_each = [for node in var.master_nodes : {
      name = node["name"]
      ip   = node["ip"]
    }]
    content {
      internal_address  = nodes.value.ip
      address           = nodes.value.ip
      hostname_override = nodes.value.name
      user              = var.system_user
      role              = ["controlplane", "etcd"]
      labels            = var.master_labels
    }
  }

  dynamic "nodes" {
    for_each = {
       for index, ip in var.worker_nodes: index => ip
    }
    content {
      internal_address  = nodes.value
      address           = nodes.value
      user              = var.system_user
      role              = ["worker"]
      labels            = var.worker_labels
    }
  }

  ingress {
    provider      = var.deploy_nginx ? "nginx" : "none"
  }

  ssh_agent_auth = var.use_ssh_agent
  ssh_key_path   = var.ssh_key_file

  kubernetes_version = var.k8s_version

  network {
    mtu = var.mtu
    plugin  = var.plugin
  }
}

resource "local_file" "kube_cluster_yaml" {
  count             = var.write_kubeconfig ? 1 : 0
  filename          = "${path.root}/kube_config_cluster.yml"
  sensitive_content = rke_cluster.cluster.kube_config_yaml
}
