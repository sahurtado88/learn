output "name" {
  value = azurerm_cosmosdb_account.cosmosdb_account.name
}
output "id" {
  value = azurerm_cosmosdb_account.cosmosdb_account.id
}
output "cosmosdb_account_endpoint" {
  value = azurerm_cosmosdb_account.cosmosdb_account.endpoint
}

output "cosmosdb_account_id" {
  value = azurerm_cosmosdb_account.cosmosdb_account.id
}

output "cosmosdb_account_primary_key" {
  value     = azurerm_cosmosdb_account.cosmosdb_account.primary_key
  sensitive = true
}
output "cosmosdb_account_secondary_key" {
  value     = azurerm_cosmosdb_account.cosmosdb_account.secondary_key
  sensitive = true
}

output "cosmosdb_account_connection_strings" {
  value     = azurerm_cosmosdb_account.cosmosdb_account.connection_strings
  sensitive = true
}