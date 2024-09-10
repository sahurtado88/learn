locals {
  aks_rg_name = var.cluster_index == "245" ? "${var.env_prefix}-rg-aks-cluster" : "${var.env_prefix}-${var.env_name}-rg-aks-cluster"
  aks_name    = var.cluster_index == "245" ? "${var.env_prefix}-aks-cluster" : "${var.env_prefix}-${var.env_name}-aks-cluster-${var.cluster_index}"
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_rg_name
}
