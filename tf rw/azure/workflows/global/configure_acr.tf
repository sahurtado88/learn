###########  ACR for storing all container images  ##
#######

module "acr_common" {
  count         = var.acr_manage ? 1 : 0
  source        = "../../modules/acr"
  location      = var.location
  location_pair = var.location_pair
  rg_name       = module.global_rg.name

  acr_name                   = var.acr_name
  acr_public_network_enabled = false
  # network_rule_set_ip_range  = var.network_rule_set_ip_range
  # network_rule_set_subnet_id = azurerm_subnet.pep.id

  #variables for Azure monitor
  env_name      = var.env_name
  env_prefix    = var.env_prefix
  alerts_manage = var.alerts_manage

}
