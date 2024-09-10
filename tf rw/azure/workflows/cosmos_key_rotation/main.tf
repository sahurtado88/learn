locals {
  rg_global             = "${var.env_prefix}-rg-global"
  rg_keyvault           = "${var.env_prefix}-${var.env_name}-rg-keyvault"
  keyvault_name         = "${var.env_prefix}-${var.env_name}-keyvault"
  cosmosdb_account_name = "${var.env_prefix}-cosmosdb"
}


data "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                = local.cosmosdb_account_name
  resource_group_name = local.rg_global
}

data "azurerm_key_vault" "akv" {
  name                = local.keyvault_name
  resource_group_name = local.rg_keyvault
}

