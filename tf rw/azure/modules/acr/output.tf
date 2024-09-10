output "login_server" {
  value = azurerm_container_registry.common_acr.login_server
}

output "admin_username" {
  value = azurerm_container_registry.common_acr.admin_username
}

output "admin_password" {
  value = azurerm_container_registry.common_acr.admin_password
}

output "acr_name" {
  value = azurerm_container_registry.common_acr.name
}

output "id" {
  value = azurerm_container_registry.common_acr.id
}