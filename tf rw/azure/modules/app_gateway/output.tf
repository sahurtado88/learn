
output "appgtwy_managed_id" {
  value = azurerm_user_assigned_identity.appgtwy.id
}


output "appgtwy_managed_object_id" {
  value = azurerm_user_assigned_identity.appgtwy.principal_id
}