locals {
  rg_global                                = "${var.env_prefix}-rg-global"
  rg_private_dns                           = "${var.env_prefix}-rg-private-dns"
  rg_general                               = "${var.env_prefix}-${var.env_name}-rg-general"
  namespace_name                           = "${var.env_prefix}-${var.env_name}-broker-ns"
  rg_tenant                                = "${var.env_prefix}-${var.env_name}-rg-tenant"
  rg_network                               = "${var.env_prefix}-${var.env_name}-rg-network"
  aks_nrg_name                             = "${var.env_prefix}-${var.env_name}-rg-aks-cluster-%03d-resources"
  aks_vnet_name                            = "${var.env_prefix}-${var.env_name}-vnet-%03d"
  pep_service_endpoint                     = "${var.env_prefix}-${var.env_name}-pep-subnet"
  user_assigned_identity_name              = "azurekeyvaultsecretsprovider-${var.env_prefix}-${var.env_name}-aks-cluster-${var.cluster_index}"
  keyvault_name                            = "${var.env_prefix}-${var.env_name}-keyvault"
  backup_policy_blob_storage_name          = "${var.env_prefix}-${var.env_name}-${var.tenant}-backup-policy"
  backup_instance_blob_storage_name        = "${var.env_prefix}-${var.env_name}-${var.tenant}-backup-instance"
  tenant_data_protection_backup_vault_name = "${var.env_prefix}-${var.env_name}-tenant-backup-vault"
  cosmosdb_account_name                    = "${var.env_prefix}-cosmosdb"
  tenant_manage_selected_networks          = var.tenant_manage_selected_networks || var.force_manage_pep
}

data "azurerm_user_assigned_identity" "azurekeyvaultsecretsprovider" {
  name                = local.user_assigned_identity_name
  resource_group_name = format(local.aks_nrg_name, var.cluster_index)
}
data "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                = local.cosmosdb_account_name
  resource_group_name = local.rg_global
}
data "azurerm_servicebus_topic_authorization_rule" "topic_event" {
  count               = var.tenant_manage_asb ? 1 : 0
  name                = "topic-event-sasPolicy"
  resource_group_name = local.rg_general
  namespace_name      = local.namespace_name
  topic_name          = "topic-event"
}
data "azurerm_servicebus_topic_authorization_rule" "topic_mgmt" {
  count               = var.tenant_manage_asb ? 1 : 0
  name                = "topic-mgmt-sasPolicy"
  resource_group_name = local.rg_general
  namespace_name      = local.namespace_name
  topic_name          = "topic-mgmt"
}

module "storageaccount" {
  providers = {
    azurerm = azurerm.tenant_sub
  }
  source                 = "../../modules/storage_account"
  rg_name                = local.rg_tenant
  location               = var.location
  storage_name           = format("%.24s", replace(var.tenant, "-", ""))
  replication_type       = var.tenant_storage_replication_type
  storage_manage_network = local.tenant_manage_selected_networks
  storage_network_access = var.tenant_storage_account_network_access
  #variables for Azure monitor
  env_name      = var.env_name
  env_prefix    = var.env_prefix
  alerts_manage = var.alerts_manage
}
module "auth_storage_blob" {
  providers = {
    azurerm = azurerm.tenant_sub
  }
  source         = "../../modules/storage_container"
  container_name = var.container_auth
  storage_name   = module.storageaccount.storage_name
}
module "tenant_storage_blob" {
  providers = {
    azurerm = azurerm.tenant_sub
  }
  source         = "../../modules/storage_container"
  container_name = var.container_tenant
  storage_name   = module.storageaccount.storage_name
}
module "dim_storage_blob" {
  providers = {
    azurerm = azurerm.tenant_sub
  }
  source         = "../../modules/storage_container"
  container_name = var.container_dim
  storage_name   = module.storageaccount.storage_name
}
module "tenant_storage_fileshare" {
  count = var.tenant_storage_fileshare ? 1 : 0
  providers = {
    azurerm = azurerm.tenant_sub
  }
  source               = "../../modules/storage_share"
  name                 = var.container_tenant
  storage_account_name = module.storageaccount.storage_name
}

# File shares for various tenant services.
# This was introduced in response to the need for supporting persistence
# of ftlinx settings for communication service. Initially we decided to map
# the parent folder with the settings to file share named "tenant" (also
# created in this module), which was unused, in order to avoid running
# terraform for all tenants. However, the longer-term vision is to use
# the properly-named share for communication service, and potentially for
# other services. 
# Also, since logistics of running tf for tenants is rather involved, we
# decided to pre-create additional shares that we may be using in the
# near future. We are intentionally creating them unconditionally; that is,
# without a "manage_*" kind of a variable. There is no harm in creating these
# shares in prod; however, in order to use them successfully, we will need to
# create private end points for them.
module "tenant_service_fileshares" {
  count = var.tenant_storage_fileshare ? length(var.tenant_service_fileshares) : 0
  providers = {
    azurerm = azurerm.tenant_sub
  }
  source               = "../../modules/storage_share"
  name                 = var.tenant_service_fileshares[count.index]
  storage_account_name = module.storageaccount.storage_name
}
