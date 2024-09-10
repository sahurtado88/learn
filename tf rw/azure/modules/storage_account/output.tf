output "primary_access_key" {
  value     = azurerm_storage_account.storage.primary_access_key
  sensitive = true
}
output "storage_name" {
  value = azurerm_storage_account.storage.name
}
output "storage_id" {
  value = azurerm_storage_account.storage.id
}
output "primary_connection_string" {
  value     = azurerm_storage_account.storage.primary_connection_string
  sensitive = true
}