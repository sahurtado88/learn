locals {
  rg_network                = "${var.env_prefix}-rg-global"
  rg_general                = "${var.env_prefix}-${var.gitlab_instance}-rg-gitlab"
  rg_waf_policy             = "${var.env_prefix}-rg-waf-policy"
  rg_private_dns            = "${var.env_prefix}-rg-private-dns"
  rg_keyvault               = "${var.env_prefix}-rg-keyvault"
  aks_rg_name               = "${var.env_prefix}-${var.gitlab_instance}-rg-aks-cluster"
  aks_nrg_name              = "${var.env_prefix}-${var.gitlab_instance}-rg-aks-cluster-resources"
  aks_name                  = "${var.env_prefix}-${var.gitlab_instance}-aks-cluster"
  aks_vnet_name             = "${var.env_prefix}-vnet-245"
  aks_subnet_name           = "${var.env_prefix}-${var.gitlab_instance}-aks-subnet"
  log_analytics_name        = "${var.env_prefix}-log-analytics-workspace"
  keyvault_name             = "${var.env_prefix}-keyvault"
  pep_subnet_name           = "${var.env_prefix}-global-pep-subnet"
  app_gateway_frontend_name = "${var.env_prefix}-${var.gitlab_instance}-application-gateway-subnet"
  app_gateway_name          = "${var.env_prefix}-${var.gitlab_instance}-application-gateway"
  # app_gateway_public_ip_name = "${var.env_prefix}-application-gateway-pip"
  app_gateway_rg_name    = "${var.env_prefix}-${var.gitlab_instance}-rg-application-gateway"
  waf_policy_name        = "${var.env_prefix}-waf-policy"
  rg_global              = "${var.env_prefix}-rg-global"
  sa_monitoring_pep_name = "${var.env_prefix}-${var.gitlab_instance}-sa-monitoring-pep"
  sa_blob_pep_name       = "${var.env_prefix}-${var.gitlab_instance}-sa-blob-pep"
  # global_aks_lb_publicip     = "${var.env_prefix}-global-aks-lb-pip"

  # gitlab
  redis_pep_name     = "${var.env_prefix}-${var.gitlab_instance}-redis-gitlab-pep"
  sa_gitlab_pep_name = "${var.env_prefix}-${var.gitlab_instance}-sa-gitlab-pep"

  # backup
  gitlab_data_protection_backup_vault_name     = "${var.env_prefix}-${var.gitlab_instance}-gitlab-backup-vault"
  gitlab_backup_policy_blob_storage_name       = "${var.env_prefix}-${var.gitlab_instance}-gitlab-backup-policy"
  gitlab_backup_instance_blob_storage_name     = "${var.env_prefix}-${var.gitlab_instance}-backup-gitlab-instance"
  monitoring_data_protection_backup_vault_name = "${var.env_prefix}-${var.gitlab_instance}-monitoring-backup-vault"
  monitoring_backup_policy_blob_storage_name   = "${var.env_prefix}-${var.gitlab_instance}-monitoring-backup-policy"
  monitoring_backup_instance_blob_storage_name = "${var.env_prefix}-${var.gitlab_instance}-backup-monitoring-instance"
}
data "azurerm_key_vault" "akv" {
  name                = local.keyvault_name
  resource_group_name = local.rg_keyvault
}

data "azurerm_virtual_network" "common_vnet" {
  name                = local.aks_vnet_name
  resource_group_name = local.rg_network
}

module "global_storage_account" {
  source           = "../../modules/storage_account"
  rg_name          = local.rg_general
  location         = var.location
  storage_name     = format("%.24s", var.gitlab_storage_account_name)
  replication_type = var.global_storage_replication_type
  # tags             = var.tags
  storage_manage_network = var.storage_account_manage_selected_networks
  storage_network_access = var.storage_account_manage_pep ? "Deny" : "Allow"
  # storage_subnet_ids     = [data.azurerm_subnet.base-endpoint.id, data.azurerm_subnet.endpoint.id]
  #variables for Azure monitor
  env_name      = "${var.env_name}-${var.gitlab_instance}"
  env_prefix    = var.env_prefix
  alerts_manage = var.alerts_manage
}
resource "azurerm_storage_container" "gitlab-backup" {
  name                  = "gitlab-backups"
  storage_account_name  = var.gitlab_storage_account_name
  container_access_type = "private"
  depends_on = [
    module.sa_blob_pep_internal
  ]
}
resource "azurerm_storage_container" "git-lfs" {
  name                  = "git-lfs"
  storage_account_name  = var.gitlab_storage_account_name
  container_access_type = "private"
  depends_on = [
    module.sa_blob_pep_internal
  ]
}