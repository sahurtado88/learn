
module "sa_functions_pep" {
  count                = var.pep_manage ? 1 : 0
  source               = "../../modules/private_endpoints"
  location             = var.location
  rg_name              = local.rg_general
  subnet_endpoint_name = local.pep_subnet_name
  pep_name             = local.sa_functions_pep_name
  pep_manual_conn      = var.sa_functions_pep_manual_conn
  private_conn_name    = module.functions_storage_account.storage_name
  private_conn_id      = module.functions_storage_account.storage_id
  network_rg_name      = local.rg_network
  pep_vnet_name        = azurerm_virtual_network.global_vnet.name
  subresource_names    = var.sa_subresource_names
  private_zone_id      = module.sa_blob_priv_dns_zone.id
  depends_on = [
    azurerm_subnet.pep,
    module.functions_storage_account.name,
    module.cosmosdb_pep_internal
  ]
}
module "functions_pep" {
  count                = var.pep_manage ? 1 : 0
  source               = "../../modules/private_endpoints"
  location             = var.location
  rg_name              = local.rg_general
  subnet_endpoint_name = local.pep_subnet_name
  pep_name             = local.functions_pep_name
  pep_manual_conn      = var.functions_pep_manual_conn
  private_conn_name    = module.azure_functions.name
  private_conn_id      = module.azure_functions.id
  network_rg_name      = local.rg_network
  pep_vnet_name        = azurerm_virtual_network.global_vnet.name
  subresource_names    = var.functions_subresource_names
  private_zone_id      = module.azurewebsites_priv_dns_zone.id
  depends_on = [
    azurerm_subnet.pep,
    module.azure_functions.name,
    module.sa_functions_pep_internal
  ]
}

module "sa_functions_pep_internal" {
  count = var.pep_manage ? 1 : 0
  providers = {
    azurerm = azurerm.ede_svcs
  }
  source               = "../../modules/private_endpoints"
  location             = var.internal_location
  rg_name              = var.internal_pep_rg_name
  subnet_endpoint_name = var.internal_pep_subnet_name
  pep_name             = join("-", [local.sa_functions_pep_name, var.internal_name])
  pep_manual_conn      = var.sa_functions_pep_manual_conn
  private_conn_name    = module.functions_storage_account.storage_name
  private_conn_id      = module.functions_storage_account.storage_id
  network_rg_name      = var.internal_network_rg_name
  pep_vnet_name        = var.internal_pep_vnet_name
  subresource_names    = var.sa_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.sa_blob_internal_private_dns[count.index].id
  depends_on = [
    module.sa_functions_pep
  ]
}

module "functions_pep_internal" {
  count = var.pep_manage ? 1 : 0
  providers = {
    azurerm = azurerm.ede_svcs
  }
  source               = "../../modules/private_endpoints"
  location             = var.internal_location
  rg_name              = var.internal_pep_rg_name
  subnet_endpoint_name = var.internal_pep_subnet_name
  pep_name             = join("-", [local.functions_pep_name, var.internal_name])
  pep_manual_conn      = var.functions_pep_manual_conn
  private_conn_name    = module.azure_functions.name
  private_conn_id      = module.azure_functions.id
  network_rg_name      = var.internal_network_rg_name
  pep_vnet_name        = var.internal_pep_vnet_name
  subresource_names    = var.functions_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.functions_internal_private_dns[count.index].id
  depends_on = [
    module.functions_pep
  ]
}