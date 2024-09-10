data "azurerm_data_protection_backup_vault" "general" {
  count               = var.backup_manage ? 1 : 0
  name                = local.general_data_protection_backup_vault_name
  resource_group_name = local.rg_general
}

resource "azurerm_data_protection_backup_policy_blob_storage" "backup_policy_blob" {
  count              = var.backup_manage ? 1 : 0
  name               = local.backup_policy_blob_storage_name
  vault_id           = data.azurerm_data_protection_backup_vault.general[count.index].id
  retention_duration = var.retention_duration
}

# monitoring blob storage account backup

resource "azurerm_role_assignment" "general" {
  count                = var.backup_manage ? 1 : 0
  scope                = module.monitoring_storage_account[0].storage_id
  role_definition_name = "Storage Account Backup Contributor"
  principal_id         = data.azurerm_data_protection_backup_vault.general[count.index].identity[0].principal_id
}

resource "azurerm_data_protection_backup_instance_blob_storage" "backup_instance_blob" {
  count              = var.backup_manage ? 1 : 0
  name               = local.backup_instance_blob_storage_name
  vault_id           = data.azurerm_data_protection_backup_vault.general[count.index].id
  location           = var.location
  storage_account_id = module.monitoring_storage_account[0].storage_id
  backup_policy_id   = azurerm_data_protection_backup_policy_blob_storage.backup_policy_blob[count.index].id

  depends_on = [azurerm_role_assignment.general]
}
