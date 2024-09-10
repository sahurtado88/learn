module "sa_blob_pep" {
  count                = var.pep_manage ? 1 : 0
  source               = "../../modules/private_endpoints"
  location             = var.location
  rg_name              = local.rg_general
  subnet_endpoint_name = local.pep_subnet_name
  pep_name             = local.sa_blob_pep_name
  pep_manual_conn      = var.sa_gl_pep_manual_conn
  private_conn_name    = module.global_storage_account.storage_name
  private_conn_id      = module.global_storage_account.storage_id
  network_rg_name      = local.rg_network
  pep_vnet_name        = data.azurerm_virtual_network.common_vnet.name
  subresource_names    = var.sa_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.sa_blob_private_dns[count.index].id
  depends_on = [
    module.global_storage_account.name,
    module.monitoring_sa_pep_internal # Because parallel PEP creation fails
  ]
}

### internal infrastructure ###
module "sa_blob_pep_internal" {
  count = var.pep_manage ? 1 : 0
  providers = {
    azurerm = azurerm.ede_svcs
  }
  source               = "../../modules/private_endpoints"
  location             = var.internal_location
  rg_name              = var.internal_pep_rg_name
  subnet_endpoint_name = var.internal_pep_subnet_name
  pep_name             = join("-", [local.sa_blob_pep_name, var.internal_name])
  pep_manual_conn      = var.sa_gl_pep_manual_conn
  private_conn_name    = module.global_storage_account.storage_name
  private_conn_id      = module.global_storage_account.storage_id
  network_rg_name      = var.internal_network_rg_name
  pep_vnet_name        = var.internal_pep_vnet_name
  subresource_names    = var.sa_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.sa_blob_internal_private_dns[count.index].id
  depends_on = [
    module.sa_blob_pep # Because parallel PEP creation fails
  ]
}