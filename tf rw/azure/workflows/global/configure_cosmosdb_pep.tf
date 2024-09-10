module "cosmosdb_pep" {
  count                = var.pep_manage ? 1 : 0
  source               = "../../modules/private_endpoints"
  location             = var.location
  rg_name              = local.rg_general
  subnet_endpoint_name = local.pep_subnet_name
  pep_name             = local.cosmosdb_pep_name
  pep_manual_conn      = var.cosmosdb_pep_manual_conn
  private_conn_name    = module.cosmosdb_account[0].name
  private_conn_id      = module.cosmosdb_account[0].id
  network_rg_name      = local.rg_network
  pep_vnet_name        = azurerm_virtual_network.global_vnet.name
  subresource_names    = var.cosmosdb_subresource_names
  # private_zone_id      = data.azurerm_private_dns_zone.sa_blob_private_dns[count.index].id
  private_zone_id = module.mongo_cosmos_priv_dns_zone.id
  depends_on = [
    # azurerm_virtual_network.global_vnet,
    azurerm_subnet.pep,
    module.cosmosdb_account.name,
    module.private_internal_endpoint
  ]
}

module "cosmosdb_pep_internal" {
  count = var.pep_manage ? 1 : 0
  providers = {
    azurerm = azurerm.ede_svcs
  }
  source               = "../../modules/private_endpoints"
  location             = var.internal_location
  rg_name              = var.internal_pep_rg_name
  subnet_endpoint_name = var.internal_pep_subnet_name
  pep_name             = join("-", [local.cosmosdb_pep_name, var.internal_name])
  pep_manual_conn      = var.cosmosdb_pep_manual_conn
  private_conn_name    = module.cosmosdb_account[0].name
  private_conn_id      = module.cosmosdb_account[0].id
  network_rg_name      = var.internal_network_rg_name
  pep_vnet_name        = var.internal_pep_vnet_name
  subresource_names    = var.cosmosdb_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.cosmosdb_internal_private_dns[count.index].id
  depends_on = [
    module.cosmosdb_pep
  ]
}