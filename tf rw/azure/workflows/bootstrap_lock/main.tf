# Validate the rg actually exists
data "azurerm_resource_group" "aks" {
  name = "${var.env_prefix}-${var.env_name}-rg-aks-cluster"
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
  name = "${var.env_prefix}-${var.env_name}-rg-application-gateway"
}

# Create/Delete lock
resource "azurerm_management_lock" "application_gateway_rg_lock" {
  count      = var.lock_manage ? 1 : 0
  name       = join("-", [data.azurerm_resource_group.gateway.name, "lock"])
  scope      = data.azurerm_resource_group.gateway.id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Resource Group"
}

# Validate the rg actually exists
data "azurerm_resource_group" "general" {
  name = "${var.env_prefix}-${var.env_name}-rg-general"
}

# Create/Delete lock
resource "azurerm_management_lock" "general_rg_lock" {
  count      = var.lock_manage ? 1 : 0
  name       = join("-", [data.azurerm_resource_group.general.name, "lock"])
  scope      = data.azurerm_resource_group.general.id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Resource Group"
}

# Validate the rg actually exists
data "azurerm_resource_group" "private_dns" {
  name = "${var.env_prefix}-${var.env_name}-rg-private-dns"
}

# Create/Delete lock
resource "azurerm_management_lock" "private_dns_rg_lock" {
  count      = var.lock_manage ? 1 : 0
  name       = join("-", [data.azurerm_resource_group.private_dns.name, "lock"])
  scope      = data.azurerm_resource_group.private_dns.id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Resource Group"
}

# Validate the rg actually exists
data "azurerm_resource_group" "keyvault" {
  name = "${var.env_prefix}-${var.env_name}-rg-keyvault"
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
data "azurerm_resource_group" "network" {
  name = "${var.env_prefix}-${var.env_name}-rg-network"
}

# Create/Delete lock
resource "azurerm_management_lock" "network_rg_lock" {
  count      = var.lock_manage ? 1 : 0
  name       = join("-", [data.azurerm_resource_group.network.name, "lock"])
  scope      = data.azurerm_resource_group.network.id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Resource Group"
}

# Validate the rg actually exists
data "azurerm_resource_group" "waf_policy" {
  name = "${var.env_prefix}-${var.env_name}-rg-waf-policy"
}

# Create/Delete lock
resource "azurerm_management_lock" "waf_policy_rg_lock" {
  count      = var.lock_manage ? 1 : 0
  name       = join("-", [data.azurerm_resource_group.waf_policy.name, "lock"])
  scope      = data.azurerm_resource_group.waf_policy.id
  lock_level = "CanNotDelete"
  notes      = "Deletion Lock for Resource Group"
}
