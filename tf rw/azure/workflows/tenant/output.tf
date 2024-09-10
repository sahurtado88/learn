output "tenant" {
  value = var.tenant
}

output "storage_name" {
  value = module.storageaccount.storage_name
}

output "uai_client_id" {
  value = data.azurerm_user_assigned_identity.azurekeyvaultsecretsprovider.client_id
}

output "uai_principal_id" {
  value = data.azurerm_user_assigned_identity.azurekeyvaultsecretsprovider.principal_id
}

output "uai_tenant_id" {
  value = data.azurerm_user_assigned_identity.azurekeyvaultsecretsprovider.tenant_id
}