locals {
  global_rg_name      = "${var.env_prefix}-${var.gitlab_instance}-rg-gitlab"
  global_aks_nrg_name = "${var.env_prefix}-${var.gitlab_instance}-rg-aks-cluster-resources"
}

# Validate the resource actually exists
data "azurerm_postgresql_flexible_server" "postgres_gitlab" {
  name                = var.gitlab_pg_name
  resource_group_name = local.global_rg_name
}

# Create/Delete lock
resource "azurerm_management_lock" "postgres_gitlab" {
  count      = var.lock_manage ? 1 : 0
  name       = join("-", [data.azurerm_postgresql_flexible_server.postgres_gitlab.name, "lock"])
  scope      = data.azurerm_postgresql_flexible_server.postgres_gitlab.id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Postgres Gitlab"
}

# Validate the rg actually exists
data "azurerm_resource_group" "aks" {
  name = local.global_aks_nrg_name
}

# Create/Delete lock
resource "azurerm_management_lock" "rg" {
  count      = var.lock_manage ? 1 : 0
  name       = join("-", [data.azurerm_resource_group.aks.name, "lock"])
  scope      = data.azurerm_resource_group.aks.id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Resource Group"
}
