locals {
  rg_general  = "${var.env_prefix}-${var.env_name}-rg-general"
  aks_rg_name = "${var.env_prefix}-${var.env_name}-rg-aks-cluster"
  aks_name    = "${var.env_prefix}-${var.env_name}-aks-cluster-000"
}
data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_rg_name
}
data "azurerm_storage_account" "monitoring_storage_account" {
  name                = var.monitoring_storage_account_name
  resource_group_name = local.rg_general
}
