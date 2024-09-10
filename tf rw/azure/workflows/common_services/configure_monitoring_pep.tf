module "monitoring_sa_pep" {
  count                = var.manage_monitoring && var.pep_manage ? 1 : 0
  source               = "../../modules/private_endpoints"
  location             = var.location
  rg_name              = local.rg_general
  subnet_endpoint_name = local.pep_subnet_name
  pep_name             = local.sa_monitoring_pep_name
  pep_manual_conn      = var.sa_monitoring_pep_manual_conn
  private_conn_name    = module.monitoring_storage_account[0].storage_name
  private_conn_id      = module.monitoring_storage_account[0].storage_id
  network_rg_name      = local.rg_network
  pep_vnet_name        = data.azurerm_virtual_network.common_vnet.name
  subresource_names    = var.sa_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.sa_mon_blob_private_dns[count.index].id
  depends_on = [
    # azurerm_virtual_network.common_vnet,
    # azurerm_subnet.endpoint,
    module.monitoring_storage_account
  ]
}

data "azurerm_private_dns_zone" "sa_mon_blob_private_dns" {
  count               = var.manage_monitoring && var.pep_manage ? 1 : 0
  name                = var.sa_blob_private_dns_name
  resource_group_name = local.rg_private_dns
}

### internal infrastructure ###
module "monitoring_sa_pep_internal" {
  count = var.manage_monitoring && var.pep_manage ? 1 : 0
  providers = {
    azurerm = azurerm.ede_svcs
  }
  source               = "../../modules/private_endpoints"
  location             = var.internal_location
  rg_name              = var.internal_pep_rg_name
  subnet_endpoint_name = var.internal_pep_subnet_name
  pep_name             = join("-", [local.sa_monitoring_pep_name, var.internal_name])
  pep_manual_conn      = var.sa_monitoring_pep_manual_conn
  private_conn_name    = module.monitoring_storage_account[0].storage_name
  private_conn_id      = module.monitoring_storage_account[0].storage_id
  network_rg_name      = var.internal_network_rg_name
  pep_vnet_name        = var.internal_pep_vnet_name
  subresource_names    = var.sa_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.sa_mon_blob_internal_private_dns[count.index].id
  depends_on = [
    module.monitoring_storage_account
  ]
}

data "azurerm_private_dns_zone" "sa_mon_blob_internal_private_dns" {
  count               = var.manage_monitoring && var.pep_manage ? 1 : 0
  provider            = azurerm.hub_dns
  name                = var.sa_blob_private_dns_name
  resource_group_name = var.hub_dns_rg_name
}
