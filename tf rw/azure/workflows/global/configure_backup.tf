# resource "azurerm_data_protection_backup_vault" "global" {
#   name                = local.global_data_protection_backup_vault_name
#   resource_group_name = module.global_rg.name
#   location            = var.location
#   datastore_type      = var.datastore_type
#   redundancy          = var.redundancy
#   identity {
#     type = "SystemAssigned"
#   }
# }

# resource "azurerm_data_protection_backup_policy_blob_storage" "backup_policy_blob" {
#   count = var.backup_manage ? 1 : 0
#   name  = local.backup_policy_blob_storage_name
#   # vault_id           = azurerm_data_protection_backup_vault.global[count.index].id
#   vault_id           = azurerm_data_protection_backup_vault.global.id
#   retention_duration = var.retention_duration
# }

# # functions blob storage account backup
### ERROR ON FUNCTION PEP UPDATE ### REMOVED << NO NEEDED
# resource "azurerm_role_assignment" "functions" {
#   count = var.backup_manage ? 1 : 0
#   # scope                = module.functions_storage_account[0].storage_id
#   scope                = module.functions_storage_account.storage_id
#   role_definition_name = "Storage Account Backup Contributor"
#   # principal_id         = azurerm_data_protection_backup_vault.global[count.index].identity[0].principal_id
#   principal_id = azurerm_data_protection_backup_vault.global.identity[0].principal_id
# }

# resource "azurerm_data_protection_backup_instance_blob_storage" "backup_instance_blob" {
#   count = var.backup_manage ? 1 : 0
#   name  = local.backup_instance_blob_storage_name
#   # vault_id           = azurerm_data_protection_backup_vault.global[count.index].id
#   vault_id = azurerm_data_protection_backup_vault.global.id
#   location = var.location
#   # storage_account_id = module.functions_storage_account[0].storage_id
#   storage_account_id = module.functions_storage_account.storage_id
#   backup_policy_id   = azurerm_data_protection_backup_policy_blob_storage.backup_policy_blob[count.index].id

#   depends_on = [azurerm_role_assignment.functions]
# }
