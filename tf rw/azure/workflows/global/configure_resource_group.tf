### {env_prefix}-rg-global

module "global_rg" {
  source   = "../../modules/resource_group"
  rg_name  = local.rg_global
  location = var.location
  tags     = var.tags
}

### {env_prefix}-rg-aks-cluster

module "aks_cluster_rg" {
  source   = "../../modules/resource_group"
  rg_name  = "${var.env_prefix}-rg-aks-cluster"
  location = var.location
  tags     = var.tags
}

### {env_prefix}-rg-application-gateway

module "application_gateway_rg" {
  source   = "../../modules/resource_group"
  rg_name  = "${var.env_prefix}-rg-application-gateway"
  location = var.location
  tags     = var.tags
}

### {env_prefix}-rg-private-dns

module "private_dns_rg" {
  source   = "../../modules/resource_group"
  rg_name  = "${var.env_prefix}-rg-private-dns"
  location = var.location
  tags     = var.tags
}

#### {env_prefix}-rg-keyvault
#
module "keyvault_rg" {
  source   = "../../modules/resource_group"
  rg_name  = "${var.env_prefix}-rg-keyvault"
  location = var.location
  tags     = var.tags
}

### {env_prefix}-rg-waf-policy

module "waf_policy_rg" {
  source   = "../../modules/resource_group"
  rg_name  = "${var.env_prefix}-rg-waf-policy"
  location = var.location
  tags     = var.tags
}
