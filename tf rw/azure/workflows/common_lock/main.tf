locals {
  default_common_cluster_index = "000"
}
# Validate the resource actually exists
data "azurerm_resource_group" "rg" {
  name = "${var.env_prefix}-${var.env_name}-rg-aks-cluster-${local.default_common_cluster_index}-resources"
}
# Create/Delete lock
resource "azurerm_management_lock" "node_resource_group_level" {
  count      = var.lock_manage ? 1 : 0
  name       = join("-", [data.azurerm_resource_group.rg.name, "lock"])
  scope      = data.azurerm_resource_group.rg.id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Resource Group"
}
