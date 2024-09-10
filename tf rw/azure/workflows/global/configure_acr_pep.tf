###########  Private Endpoints Application and EDE ##
#######

data "azurerm_private_dns_zone" "pep_internal_private_dns" {
  count               = var.pep_manage ? 1 : 0
  provider            = azurerm.hub_dns
  name                = var.acr_private_dns_name
  resource_group_name = var.hub_dns_rg_name
}
### application infrastructure ###
module "private_endpoint" {
  count                = var.pep_manage && var.acr_manage ? 1 : 0
  source               = "../../modules/private_endpoints"
  location             = var.location
  rg_name              = module.global_rg.name
  subnet_endpoint_name = azurerm_subnet.pep.name
  pep_name             = local.acr_pep_name
  pep_manual_conn      = var.global_pep_manual_conn
  private_conn_name    = var.acr_name
  private_conn_id      = module.acr_common[count.index].id
  network_rg_name      = module.global_rg.name
  pep_vnet_name        = azurerm_virtual_network.global_vnet.name
  subresource_names    = var.boot_subresource_names
  private_zone_id      = module.acr_priv_dns_zone.id
  depends_on = [
    azurerm_virtual_network.global_vnet
  ]
}
### application infrastructure ###
module "private_internal_endpoint" {
  count = var.pep_manage && var.acr_manage ? 1 : 0
  providers = {
    azurerm = azurerm.ede_svcs
  }
  source               = "../../modules/private_endpoints"
  location             = var.internal_location
  rg_name              = var.internal_pep_rg_name
  subnet_endpoint_name = var.internal_pep_subnet_name
  pep_name             = join("-", [local.acr_pep_name, var.internal_name])
  pep_manual_conn      = var.global_pep_manual_conn
  private_conn_name    = var.acr_name
  private_conn_id      = module.acr_common[count.index].id
  network_rg_name      = var.internal_network_rg_name
  pep_vnet_name        = var.internal_pep_vnet_name
  subresource_names    = var.boot_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.pep_internal_private_dns[count.index].id
  depends_on = [
    module.private_endpoint
  ]
}

