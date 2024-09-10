resource "azurerm_kubernetes_cluster_extension" "aks_extension_flux" {
  name           = var.aks_flux_extension_name
  cluster_id     = var.aks_id
  extension_type = "microsoft.flux"
  configuration_settings = {
    "multiTenancy.enforce" = false
    "useKubeletIdentity"   = true
  }
}

resource "azurerm_kubernetes_flux_configuration" "aks_extension_flux_config" {
  cluster_id = var.aks_id
  name       = var.aks_flux_config_name
  namespace  = var.flux_config_ns
  scope      = "cluster"

  git_repository {
    url              = var.flux_git_url
    reference_type   = var.flux_git_reference_type
    reference_value  = var.flux_git_reference_value
    https_user       = var.flux_git_https_user
    https_key_base64 = base64encode(var.flux_git_https_key)
  }

  dynamic "kustomizations" {
    for_each = var.flux_kustomizations
    content {
      name = kustomizations.value.name
      path = kustomizations.value.path
    }
  }

  depends_on = [azurerm_kubernetes_cluster_extension.aks_extension_flux]
}
