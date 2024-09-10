locals {
  rg_global                    = "${var.env_prefix}-rg-global"
  cosmosdb_account_name        = "${var.env_prefix}-cosmosdb"
  cosmosdb_database_name_authz = "authz"
  cosmosdb_database_name_dim   = "dim"
}

data "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                = local.cosmosdb_account_name
  resource_group_name = local.rg_global
}

resource "azurerm_cosmosdb_mongo_database" "cosmosdb_database" {
  count               = var.manage_cosmosdb ? 1 : 0
  name                = local.cosmosdb_database_name_authz
  resource_group_name = local.rg_global
  account_name        = data.azurerm_cosmosdb_account.cosmosdb_account.name
  autoscale_settings {
    max_throughput = var.cosmosdb_throughput_authz
  }
}

resource "azurerm_cosmosdb_mongo_database" "cosmosdb_database_dim" {
  count               = var.manage_cosmosdb ? 1 : 0
  name                = local.cosmosdb_database_name_dim
  resource_group_name = local.rg_global
  account_name        = data.azurerm_cosmosdb_account.cosmosdb_account.name
  autoscale_settings {
    max_throughput = var.cosmosdb_throughput_dim
  }
}