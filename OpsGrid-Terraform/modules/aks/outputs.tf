output "cluster_name" {
  value = azurerm_kubernetes_cluster.opsgrid.name
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.opsgrid.kube_config_raw
  sensitive = true
}

output "kubelet_identity_object_id" {
  value = azurerm_kubernetes_cluster.opsgrid.kubelet_identity[0].object_id
}