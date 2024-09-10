locals {
  super_set    = [for i in range(1, tonumber(var.max_clusters) + 1) : tostring(i)]
  cluster_list = var.cluster_list == "" ? var.lock_manage ? [] : local.super_set : split(",", var.cluster_list)
  cluster_set  = var.lock_manage ? toset(local.super_set) : setsubtract(local.super_set, local.cluster_list)
}
# Validate the all the rg actually exists
data "azurerm_resource_group" "rgs" {
  for_each = local.cluster_set
  name     = format("${var.env_prefix}-${var.env_name}-rg-aks-cluster-%03s-resources", each.value)
}
# Create/Delete lock
resource "azurerm_management_lock" "rgs" {
  for_each   = data.azurerm_resource_group.rgs
  name       = join("-", [each.value.name, "lock"])
  scope      = each.value.id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Resource Group"
}
