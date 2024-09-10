locals {
  data_protection_backup_vault_name = "ftdsp-tfstate-backup-vault"
  backup_policy_blob_storage_name   = "ftdsp-tfstate-backup-policy"
  backup_instance_blob_storage_name = "ftdsp-tfstate-backup-instance"
}

module "resource_group" {
  source   = "../../modules/resource_group"
  rg_name  = var.tfstate_rg_name
  location = var.location
  tags     = var.tags
}

module "storage_account" {
  source                 = "../../modules/storage_account"
  rg_name                = var.tfstate_rg_name
  location               = var.location
  replication_type       = var.storage_replication_type
  storage_name           = var.tfstate_storage_account_name
  depends_on             = [module.resource_group]
  storage_network_access = "Deny"
  storage_manage_network = true
  # tags                   = var.tags
  #variables for Azure monitor
  env_name      = var.env_name
  env_prefix    = var.env_prefix
  alerts_manage = var.alerts_manage
}

resource "azurerm_storage_container" "container" {
  count = length(var.tfstate_container_names)
  name  = var.tfstate_container_names[count.index]
  #name                  = var.tfstate_container_name
  storage_account_name  = var.tfstate_storage_account_name
  container_access_type = "private"
  depends_on            = [module.storage_account]
}


# module "storageaccount" {
#   source                 = "../../modules/storage_account"
#   rg_name                = local.rg_tenant
#   location               = var.location
#   storage_name           = format("%.24s", var.tenant)
#   replication_type       = var.tenant_storage_replication_type
#   tags                   = var.tags
#   storage_manage_network = var.tenant_manage_selected_networks
#   storage_network_access = var.tenant_storage_account_network_access
#   storage_subnet_ids     = [data.azurerm_subnet.base-endpoint.id, data.azurerm_subnet.endpoint.id]
# }