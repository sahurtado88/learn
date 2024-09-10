# common blob storage account backup (gitlab)

resource "azurerm_data_protection_backup_vault" "gitlab" {
  count               = var.backup_manage ? 1 : 0
  name                = local.gitlab_data_protection_backup_vault_name
  resource_group_name = local.rg_global
  location            = var.location
  datastore_type      = var.datastore_type
  redundancy          = var.redundancy
  identity {
    type = "SystemAssigned"
  }
}
resource "azurerm_data_protection_backup_policy_blob_storage" "gitlab_backup_policy_blob" {
  count              = var.backup_manage ? 1 : 0
  name               = local.gitlab_backup_policy_blob_storage_name
  vault_id           = azurerm_data_protection_backup_vault.gitlab[count.index].id
  retention_duration = var.retention_duration
}
resource "azurerm_role_assignment" "gitlab" {
  count                = var.backup_manage ? 1 : 0
  scope                = module.global_storage_account.storage_id
  role_definition_name = "Storage Account Backup Contributor"
  principal_id         = azurerm_data_protection_backup_vault.gitlab[count.index].identity[0].principal_id
  depends_on = [
    module.sa_gitlab_pep_internal
  ]
}

resource "azurerm_data_protection_backup_instance_blob_storage" "backup_instance_blob_gitlab" {
  count              = var.backup_manage ? 1 : 0
  name               = local.gitlab_backup_instance_blob_storage_name
  vault_id           = azurerm_data_protection_backup_vault.gitlab[count.index].id
  location           = var.location
  storage_account_id = module.global_storage_account.storage_id
  backup_policy_id   = azurerm_data_protection_backup_policy_blob_storage.gitlab_backup_policy_blob[count.index].id

  depends_on = [azurerm_role_assignment.gitlab]
}

# monitoring blob storage account backup
resource "azurerm_data_protection_backup_vault" "monitoring" {
  count               = var.backup_manage ? 1 : 0
  name                = local.monitoring_data_protection_backup_vault_name
  resource_group_name = local.rg_global
  location            = var.location
  datastore_type      = var.datastore_type
  redundancy          = var.redundancy
  identity {
    type = "SystemAssigned"
  }
}
resource "azurerm_data_protection_backup_policy_blob_storage" "monitoring_backup_policy_blob" {
  count              = var.backup_manage ? 1 : 0
  name               = local.monitoring_backup_policy_blob_storage_name
  vault_id           = azurerm_data_protection_backup_vault.monitoring[count.index].id
  retention_duration = var.retention_duration
}
resource "azurerm_role_assignment" "monitoring" {
  count                = var.backup_manage ? 1 : 0
  scope                = module.monitoring_storage_account[0].storage_id
  role_definition_name = "Storage Account Backup Contributor"
  principal_id         = azurerm_data_protection_backup_vault.monitoring[count.index].identity[0].principal_id
  depends_on = [
    module.monitoring_sa_pep_internal
  ]
}

resource "azurerm_data_protection_backup_instance_blob_storage" "backup_instance_blob_monitoring" {
  count              = var.backup_manage ? 1 : 0
  name               = local.monitoring_backup_instance_blob_storage_name
  vault_id           = azurerm_data_protection_backup_vault.monitoring[count.index].id
  location           = var.location
  storage_account_id = module.monitoring_storage_account[0].storage_id
  backup_policy_id   = azurerm_data_protection_backup_policy_blob_storage.monitoring_backup_policy_blob[count.index].id
  # waiting to finish previous backup instance, parallel operation are not supported 
  depends_on = [azurerm_role_assignment.monitoring]
}
