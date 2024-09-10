resource "azurerm_data_protection_backup_vault" "tfstate" {
  name                = local.data_protection_backup_vault_name
  resource_group_name = module.resource_group.name
  location            = var.location
  datastore_type      = var.datastore_type
  redundancy          = var.redundancy
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_data_protection_backup_policy_blob_storage" "backup_policy_blob" {
  count              = var.tfstate_backup_manage ? 1 : 0
  name               = local.backup_policy_blob_storage_name
  vault_id           = azurerm_data_protection_backup_vault.tfstate.id
  retention_duration = var.retention_duration
}

resource "azurerm_role_assignment" "tfstate" {
  count                = var.tfstate_backup_manage ? 1 : 0
  scope                = module.storage_account.storage_id
  role_definition_name = "Storage Account Backup Contributor"
  principal_id         = azurerm_data_protection_backup_vault.tfstate.identity[0].principal_id
}

resource "azurerm_data_protection_backup_instance_blob_storage" "backup_instance_blob" {
  count              = var.tfstate_backup_manage ? 1 : 0
  name               = local.backup_instance_blob_storage_name
  vault_id           = azurerm_data_protection_backup_vault.tfstate.id
  location           = var.location
  storage_account_id = module.storage_account.storage_id
  backup_policy_id   = azurerm_data_protection_backup_policy_blob_storage.backup_policy_blob[count.index].id

  depends_on = [azurerm_role_assignment.tfstate]
}
