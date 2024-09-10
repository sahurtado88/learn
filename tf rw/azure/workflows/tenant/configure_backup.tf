data "azurerm_data_protection_backup_vault" "tenant" {
  count               = var.tenant_backup_manage ? 1 : 0
  name                = local.tenant_data_protection_backup_vault_name
  resource_group_name = local.rg_tenant
}

resource "azurerm_data_protection_backup_policy_blob_storage" "backup_policy_blob" {
  count              = var.tenant_backup_manage ? 1 : 0
  name               = local.backup_policy_blob_storage_name
  vault_id           = data.azurerm_data_protection_backup_vault.tenant[count.index].id
  retention_duration = var.retention_duration
}

resource "azurerm_role_assignment" "tenant" {
  count                = var.tenant_backup_manage ? 1 : 0
  scope                = module.storageaccount.storage_id
  role_definition_name = "Storage Account Backup Contributor"
  principal_id         = data.azurerm_data_protection_backup_vault.tenant[count.index].identity[0].principal_id
}

resource "azurerm_data_protection_backup_instance_blob_storage" "backup_instance_blob" {
  count              = var.tenant_backup_manage ? 1 : 0
  name               = local.backup_instance_blob_storage_name
  vault_id           = data.azurerm_data_protection_backup_vault.tenant[count.index].id
  location           = var.location
  storage_account_id = module.storageaccount.storage_id
  backup_policy_id   = azurerm_data_protection_backup_policy_blob_storage.backup_policy_blob[count.index].id

  depends_on = [azurerm_role_assignment.tenant]
}
