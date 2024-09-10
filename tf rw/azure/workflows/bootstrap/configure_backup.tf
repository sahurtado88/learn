resource "azurerm_data_protection_backup_vault" "tenant" {
  name                = local.tenant_data_protection_backup_vault_name
  resource_group_name = module.tenant_rg.name
  location            = var.location
  datastore_type      = var.datastore_type
  redundancy          = var.redundancy
  identity {
    type = "SystemAssigned"
  }
}
resource "azurerm_data_protection_backup_vault" "general" {
  name                = local.general_data_protection_backup_vault_name
  resource_group_name = module.general_rg.name
  location            = var.location
  datastore_type      = var.datastore_type
  redundancy          = var.redundancy
  identity {
    type = "SystemAssigned"
  }
}