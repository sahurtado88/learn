### ftds-{env}-rg-aks-cluster
module "aks_cluster_rg" {
  source   = "../../modules/resource_group"
  rg_name  = "${var.env_prefix}-${var.env_name}-rg-aks-cluster"
  location = var.location
  tags     = var.tags
}


### ftds-{env}-rg-application-gateway
module "application_gateway_rg" {
  source   = "../../modules/resource_group"
  rg_name  = "${var.env_prefix}-${var.env_name}-rg-application-gateway"
  location = var.location
  tags     = var.tags
}

#### ftds-{env}-rg-general
module "general_rg" {
  source   = "../../modules/resource_group"
  rg_name  = "${var.env_prefix}-${var.env_name}-rg-general"
  location = var.location
  tags     = var.tags
}

### ftds-{env}-rg-private-dns
module "private_dns_rg" {
  source   = "../../modules/resource_group"
  rg_name  = "${var.env_prefix}-${var.env_name}-rg-private-dns"
  location = var.location
  tags     = var.tags
}

#### ftds-{env}-rg-keyvault
module "keyvault_rg" {
  source   = "../../modules/resource_group"
  rg_name  = "${var.env_prefix}-${var.env_name}-rg-keyvault"
  location = var.location
  tags     = var.tags
}

### ftds-{env}-rg-network
module "network_rg" {
  source   = "../../modules/resource_group"
  rg_name  = "${var.env_prefix}-${var.env_name}-rg-network"
  location = var.location
  tags     = var.tags
}

#### ftds-{env}-rg-tenant
module "tenant_rg" {
  source   = "../../modules/resource_group"
  rg_name  = "${var.env_prefix}-${var.env_name}-rg-tenant"
  location = var.location
  tags     = var.tags
}

### ftds-{env}-rg-waf-policy
module "waf_policy_rg" {
  source   = "../../modules/resource_group"
  rg_name  = "${var.env_prefix}-${var.env_name}-rg-waf-policy"
  location = var.location
  tags     = var.tags
}
