output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_client_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
}

output "aks_client_key" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
}

output "aks_cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
}

output "aks_host" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].host
}

output "aks_username" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].username
}

output "aks_password" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].password
}

# output "aks_resource_group_id" {
#   value = azurerm_resource_group.aks_rg.id
# }

output "aks_managed_identity_principal_id" {
  value = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

output "keyvault_secret_identity" {
  value = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0]
}

output "aks_kubelet_identity" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

output "aks_lb_pip_id" {
  value = azurerm_public_ip.akslbpublicip.id
}

output "aks_oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.aks.oidc_issuer_url
}
