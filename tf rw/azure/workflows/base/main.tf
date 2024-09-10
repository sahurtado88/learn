locals {
  rg_network                = "${var.env_prefix}-${var.env_name}-rg-network"
  rg_general                = "${var.env_prefix}-${var.env_name}-rg-general"
  rg_waf_policy             = "${var.env_prefix}-${var.env_name}-rg-waf-policy"
  rg_keyvault               = "${var.env_prefix}-${var.env_name}-rg-keyvault"
  rg_application_gateway    = "${var.env_prefix}-${var.env_name}-rg-application-gateway"
  rg_tenant                 = "${var.env_prefix}-${var.env_name}-rg-tenant"
  app_gateway_frontend_name = "${var.env_prefix}-${var.env_name}-%03d-application-gateway-subnet"
  app_gateway_name          = "${var.env_prefix}-${var.env_name}-application-gateway-%03d"
  # app_gateway_public_ip_name  = "${var.env_prefix}-${var.env_name}-application-gateway-%03d-pip"
  app_gateway_vnet_name = "${var.env_prefix}-${var.env_name}-vnet-%03d"
  waf_policy_name       = "${var.env_prefix}-${var.env_name}-waf-policy"
  keyvault_name         = "${var.env_prefix}-${var.env_name}-keyvault"
  aks_rg_name           = "${var.env_prefix}-${var.env_name}-rg-aks-cluster"
  aks_nrg_name          = "${var.env_prefix}-${var.env_name}-rg-aks-cluster-%03d-resources"
  aks_name              = "${var.env_prefix}-${var.env_name}-aks-cluster-${var.cluster_index}"
  aks_vnet_name         = "${var.env_prefix}-${var.env_name}-vnet-%03d"
  # aks_lb_publicip_name        = "${var.env_prefix}-${var.env_name}-%03d-aks-lb-pip"
  aks_subnet_name      = "${var.env_prefix}-${var.env_name}-${var.cluster_index}-aks-subnet"
  log_analytics_name   = "${var.env_prefix}-${var.env_name}-log-analytics-workspace"
  rg_global            = "${var.env_prefix}-rg-global"
  global_keyvault_name = "${var.env_prefix}-keyvault"
  rg_global_keyvault   = "${var.env_prefix}-rg-keyvault"
}

data "azurerm_key_vault" "global_akv" {
  name                = local.global_keyvault_name
  resource_group_name = local.rg_global_keyvault
}