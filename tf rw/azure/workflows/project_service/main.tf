locals {
  rg_global             = "${var.env_prefix}-rg-global"
  cosmosdb_account_name = "${var.env_prefix}-cosmosdb"
  aks_rg_name           = "${var.env_prefix}-${var.env_name}-rg-aks-cluster"
  aks_name              = "${var.env_prefix}-${var.env_name}-aks-cluster-000"
}
data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_rg_name
}
