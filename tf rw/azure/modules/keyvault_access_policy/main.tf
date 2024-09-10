resource "azurerm_key_vault_access_policy" "akv_access_policy" {
  key_vault_id            = var.keyvault_id
  tenant_id               = var.keyvault_tenant_id
  object_id               = var.keyvault_object_id
  certificate_permissions = var.keyvault_cert_permissions
  key_permissions         = var.keyvault_key_permissions
  secret_permissions      = var.keyvault_secret_permissions
}
