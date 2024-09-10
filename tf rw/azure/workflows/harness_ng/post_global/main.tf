locals {
  rg_global = "${var.env_prefix}-rg-global"
}

data "azurerm_container_registry" "acr_common" {
  name                = var.acr_name
  resource_group_name = local.rg_global
}

##
# Configure ACR
##

resource "harness_platform_secret_text" "acr_username" {
  identifier                = var.secret_acr_username
  name                      = var.secret_acr_username
  value                     = data.azurerm_container_registry.acr_common.admin_username
  value_type                = "Inline"
  secret_manager_identifier = var.harness_secret_manager_identifier
}

resource "harness_platform_secret_text" "acr_password" {
  identifier                = var.secret_acr_password
  name                      = var.secret_acr_password
  value                     = data.azurerm_container_registry.acr_common.admin_password
  value_type                = "Inline"
  secret_manager_identifier = var.harness_secret_manager_identifier
}

resource "harness_platform_secret_text" "acr_server" {
  identifier                = var.secret_acr_server
  name                      = var.secret_acr_server
  value                     = data.azurerm_container_registry.acr_common.login_server
  value_type                = "Inline"
  secret_manager_identifier = var.harness_secret_manager_identifier
}
