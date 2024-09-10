data "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                = var.cosmosdb_account_name
  resource_group_name = var.cosmosdb_account_resource_group_name
}

resource "azurerm_cosmosdb_mongo_database" "cosmosdb_database" {
  name                = var.cosmosdb_database_name
  resource_group_name = data.azurerm_cosmosdb_account.cosmosdb_account.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.cosmosdb_account.name
  # throughput          = var.cosmosdb_throughput
  autoscale_settings {
    max_throughput = var.cosmosdb_throughput
  }
}
