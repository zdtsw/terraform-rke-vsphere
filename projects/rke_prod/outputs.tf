output "cluster_name" {
  value       = var.cluster_name
  description = "Cluster name"
}

output "rke_cluster" {
  value       = module.rke.rke_cluster
  description = "RKE cluster spec"
  sensitive   = "true"
}