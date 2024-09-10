locals {
  rg_network                = "${var.env_prefix}-${var.env_name}-rg-network"
  rg_general                = "${var.env_prefix}-${var.env_name}-rg-general"
  rg_waf_policy             = "${var.env_prefix}-${var.env_name}-rg-waf-policy"
  rg_keyvault               = "${var.env_prefix}-${var.env_name}-rg-keyvault"
  aks_rg_name               = "${var.env_prefix}-${var.env_name}-rg-aks-cluster"
  aks_name                  = "${var.env_prefix}-${var.env_name}-aks-cluster-000"
  aks_vnet_name             = "${var.env_prefix}-${var.env_name}-vnet-000"
  aks_nrg_name              = "${var.env_prefix}-${var.env_name}-rg-aks-cluster-000-resources"
  aks_subnet_name           = "${var.env_prefix}-${var.env_name}-000-aks-subnet"
  log_analytics_name        = "${var.env_prefix}-${var.env_name}-log-analytics-workspace"
  keyvault_name             = "${var.env_prefix}-${var.env_name}-keyvault"
  pep_subnet_name           = "${var.env_prefix}-${var.env_name}-pep-subnet"
  app_gateway_frontend_name = "${var.env_prefix}-${var.env_name}-000-application-gateway-subnet"
  app_gateway_name          = "${var.env_prefix}-${var.env_name}-application-gateway-000"
  # app_gateway_public_ip_name   = "${var.env_prefix}-${var.env_name}-application-gateway-000-pip"
  app_gateway_rg_name    = "${var.env_prefix}-${var.env_name}-rg-application-gateway"
  waf_policy_name        = "${var.env_prefix}-${var.env_name}-waf-policy"
  rg_global              = "${var.env_prefix}-rg-global"
  global_rg_keyvault     = "${var.env_prefix}-rg-keyvault"
  global_keyvault_name   = "${var.env_prefix}-keyvault"
  rg_private_dns         = "${var.env_prefix}-rg-private-dns"
  sa_monitoring_pep_name = "${var.env_prefix}-${var.env_name}-sa-monitoring-pep"
  # cmn_aks_lb_publicip          = "${var.env_prefix}-${var.env_name}-000-aks-lb-pip"

  # deployment function
  function_app_name = "${var.env_prefix}-deployment-functions"
  function_endpoint = "https://${var.env_prefix}-deployment-functions.azurewebsites.net"

  # backup
  general_data_protection_backup_vault_name = "${var.env_prefix}-${var.env_name}-general-backup-vault"
  backup_policy_blob_storage_name           = "${var.env_prefix}-${var.env_name}-backup-policy"
  backup_instance_blob_storage_name         = "${var.env_prefix}-${var.env_name}-backup-instance"

  # catalog
  cosmosdb_account_name = "${var.env_prefix}-cosmosdb"
}

data "azurerm_key_vault" "global_akv" {
  name                = local.global_keyvault_name
  resource_group_name = local.global_rg_keyvault
}
data "azurerm_key_vault" "akv" {
  name                = local.keyvault_name
  resource_group_name = local.rg_keyvault
}

data "azurerm_virtual_network" "common_vnet" {
  name                = local.aks_vnet_name
  resource_group_name = local.rg_network
}

module "delegation_service_workload_identity" {
  count                 = var.delegation_manage ? 1 : 0
  source                = "../../modules/managed_identity"
  rg_name               = local.aks_nrg_name
  location              = var.location
  managed_identity_name = var.delegation_service_workload_identity_name
}

resource "azurerm_role_assignment" "storage_contributor" {
  count                = var.delegation_manage ? 1 : 0
  scope                = "/subscriptions/${var.azure_subscription_id_global}/resourceGroups/${var.env_prefix}-rg-apim"
  role_definition_name = "API Management Service Contributor"
  principal_id         = module.delegation_service_workload_identity[count.index].principal_id
}