data "azurerm_client_config" "current" {}

module "keyvault" {
  count                      = var.key_vault_manage ? 1 : 0
  source                     = "../../modules/keyvault"
  name                       = local.keyvault_name
  location                   = var.location
  resource_group_name        = module.keyvault_rg.name
  soft_delete_retention_days = var.key_vault_soft_delete
  sku_name                   = var.key_vault_sku
  object_id                  = data.azurerm_client_config.current.object_id
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  # certificate_permissions            = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
  # key_permissions                    = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnWrapKey", "Update", "Verify", "WrapKey"]
  # secret_permissions                 = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
  key_vault_manage_selected_networks = var.key_vault_manage_selected_networks
  #variables for Azure monitor
  env_name      = var.env_name
  env_prefix    = var.env_prefix
  alerts_manage = var.alerts_manage
}
