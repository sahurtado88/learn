locals {
  rg_name   = "ftds-monitoring-alerts"
  is_global = startswith(var.env_name, "gl") ? true : false
}

#Create action groups for preprod & prod environment
module "actiongroup_vault" {
  count               = var.alerts_manage && local.is_global ? 0 : 1
  source              = "../../modules/alerts_actiongroup"
  actiongroup_suffix  = "Vault"
  env_name            = var.env_name
  env_prefix          = var.env_prefix
  actiongroup_rg      = local.rg_name
  webhook_service_uri = var.service_uri_vault
}

module "actiongroup_sa" {
  count               = var.alerts_manage && local.is_global ? 0 : 1
  source              = "../../modules/alerts_actiongroup"
  actiongroup_suffix  = "SA"
  env_name            = var.env_name
  env_prefix          = var.env_prefix
  actiongroup_rg      = local.rg_name
  webhook_service_uri = var.service_uri_sa
}

module "actiongroup_network" {
  count               = var.alerts_manage && local.is_global ? 0 : 1
  source              = "../../modules/alerts_actiongroup"
  actiongroup_suffix  = "Network"
  env_name            = var.env_name
  env_prefix          = var.env_prefix
  actiongroup_rg      = local.rg_name
  webhook_service_uri = var.service_uri_network
}

module "actiongroup_appgw" {
  count               = var.alerts_manage ? 1 : 0
  source              = "../../modules/alerts_actiongroup"
  actiongroup_suffix  = "AppGW"
  env_name            = var.env_name
  env_prefix          = var.env_prefix
  actiongroup_rg      = local.rg_name
  webhook_service_uri = var.service_uri_appgw
}

module "actiongroup_aks" {
  count               = var.alerts_manage ? 1 : 0
  source              = "../../modules/alerts_actiongroup"
  actiongroup_suffix  = "AKS"
  env_name            = var.env_name
  env_prefix          = var.env_prefix
  actiongroup_rg      = local.rg_name
  webhook_service_uri = var.service_uri_aks
}

module "actiongroup_db" {
  count               = var.alerts_manage ? 1 : 0
  source              = "../../modules/alerts_actiongroup"
  actiongroup_suffix  = "DBs"
  env_name            = var.env_name
  env_prefix          = var.env_prefix
  actiongroup_rg      = local.rg_name
  webhook_service_uri = var.service_uri_db
}

module "actiongroup_security" {
  count               = var.alerts_manage ? 1 : 0
  source              = "../../modules/alerts_actiongroup"
  actiongroup_suffix  = "Security"
  env_name            = var.env_name
  env_prefix          = var.env_prefix
  actiongroup_rg      = local.rg_name
  webhook_service_uri = var.service_uri_security
}
