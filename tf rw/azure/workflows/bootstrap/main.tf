locals {
  keyvault_name                             = "${var.env_prefix}-${var.env_name}-keyvault"
  keyvault_pep_name                         = "${var.env_prefix}-${var.env_name}-keyvault-pep"
  log_analytics_name                        = "${var.env_prefix}-${var.env_name}-log-analytics-workspace"
  pep_subnet_name                           = "${var.env_prefix}-${var.env_name}-pep-subnet"
  aks_vnets_name                            = "${var.env_prefix}-${var.env_name}-vnet-%03d"
  base_vnet_peering                         = "${var.env_prefix}-${var.env_name}-vnet-%03d-vnet-000-peering"
  common_vnet_peering                       = "${var.env_prefix}-${var.env_name}-vnet-000-vnet-%03d-peering"
  local_vnet_peering                        = "${var.env_prefix}-${var.env_name}-local-%03d-global-peering"
  global_vnet_peering                       = "${var.env_prefix}-${var.env_name}-global-local-%03d-peering"
  fw_policy_name                            = "${var.env_prefix}-${var.env_name}-waf-policy"
  fw_grafana_policy_name                    = "${var.env_prefix}-${var.env_name}-grafana-waf-policy"
  rg_global                                 = "${var.env_prefix}-rg-global"
  rg_global_private_dns                     = "${var.env_prefix}-rg-private-dns"
  global_vnet_name                          = "${var.env_prefix}-vnet-245"
  tenant_data_protection_backup_vault_name  = "${var.env_prefix}-${var.env_name}-tenant-backup-vault"
  general_data_protection_backup_vault_name = "${var.env_prefix}-${var.env_name}-general-backup-vault"
  fluxcd_sops_key                           = "${var.env_prefix}-${var.env_name}-fluxcd-sops"
}


