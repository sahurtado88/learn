locals {
  aks_rg_name        = "${var.env_prefix}-${var.gitlab_instance}-rg-aks-cluster"
  alerts_rg_name     = "ftds-monitoring-alerts"
  gateway_rg_name    = "${var.env_prefix}-${var.gitlab_instance}-rg-application-gateway"
  keyvault_rg_name   = "${var.env_prefix}-rg-keyvault"
  waf_policy_rg_name = "${var.env_prefix}-rg-waf-policy"
  func_sa_name       = "${var.env_prefix}rafuncsa"
  global_rg_name     = "${var.env_prefix}-rg-global"
  cosmosdb_name      = "${var.env_prefix}-cosmosdb"
  func_name          = "${var.env_prefix}-deployment-functions"
}

# Validate the rg actually exists
data "azurerm_resource_group" "aks" {
  name = local.aks_rg_name
}

# Create/Delete lock
resource "azurerm_management_lock" "aks_cluster_rg_lock" {
  count      = var.lock_manage ? 1 : 0
  name       = join("-", [data.azurerm_resource_group.aks.name, "lock"])
  scope      = data.azurerm_resource_group.aks.id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Resource Group"
}

# Validate the rg actually exists
data "azurerm_resource_group" "gateway" {
  name = local.gateway_rg_name
}

# Create/Delete lock
resource "azurerm_management_lock" "application_gateway_rg_lock" {
  count      = var.lock_manage ? 1 : 0
  name       = join("-", [data.azurerm_resource_group.gateway.name, "lock"])
  scope      = data.azurerm_resource_group.gateway.id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Resource Group"
}

#Validate the resource actually exists
data "azurerm_resource_group" "alerts" {
  count = (var.alerts_manage && var.env_name == var.env_name_global) ? 1 : 0
  name  = local.alerts_rg_name
}

# Create/Delete lock
resource "azurerm_management_lock" "monitoring_alerts_rg_lock" {
  count      = (var.alerts_manage && var.env_name == var.env_name_global) ? 1 : 0
  name       = join("-", [data.azurerm_resource_group.alerts[0].name, "lock"])
  scope      = data.azurerm_resource_group.alerts[0].id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Resource Group"
}

# Validate the rg actually exists
data "azurerm_resource_group" "keyvault" {
  name = local.keyvault_rg_name
}

# Create/Delete lock
resource "azurerm_management_lock" "keyvault_rg_lock" {
  count      = var.lock_manage ? 1 : 0
  name       = join("-", [data.azurerm_resource_group.keyvault.name, "lock"])
  scope      = data.azurerm_resource_group.keyvault.id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Resource Group"
}

# Validate the rg actually exists
data "azurerm_resource_group" "waf_policy" {
  name = local.waf_policy_rg_name
}

resource "azurerm_management_lock" "waf_policy_rg_lock" {
  count      = var.lock_manage ? 1 : 0
  name       = join("-", [data.azurerm_resource_group.waf_policy.name, "lock"])
  scope      = data.azurerm_resource_group.waf_policy.id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Resource Group"
}

# Validate the sa actually exists
data "azurerm_storage_account" "function" {
  resource_group_name = local.global_rg_name
  name                = local.func_sa_name
}

# Create/Delete lock
resource "azurerm_management_lock" "func_sa_lock" {
  count      = var.lock_manage ? 1 : 0
  name       = join("-", [data.azurerm_storage_account.function.name, "lock"])
  scope      = data.azurerm_storage_account.function.id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Resource Group"
}

# Validate the db actually exists
data "azurerm_cosmosdb_account" "global" {
  resource_group_name = local.global_rg_name
  name                = local.cosmosdb_name
}

# Create/Delete lock
resource "azurerm_management_lock" "cosmosdb_lock" {
  count      = var.lock_manage ? 1 : 0
  name       = join("-", [data.azurerm_cosmosdb_account.global.name, "lock"])
  scope      = data.azurerm_cosmosdb_account.global.id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Resource Group"
}

# Validate the func actually exists
data "azurerm_linux_function_app" "global" {
  resource_group_name = local.global_rg_name
  name                = local.func_name
}

# Create/Delete lock
resource "azurerm_management_lock" "functions_lock" {
  count      = var.lock_manage ? 1 : 0
  name       = join("-", [data.azurerm_linux_function_app.global.name, "lock"])
  scope      = data.azurerm_linux_function_app.global.id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Resource Group"
}
