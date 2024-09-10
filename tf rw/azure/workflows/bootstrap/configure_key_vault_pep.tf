data "azurerm_private_dns_zone" "kv_internal_private_dns" {
  count               = var.pep_manage && var.key_vault_manage ? 1 : 0
  provider            = azurerm.hub_dns
  name                = var.kv_private_dns_name
  resource_group_name = var.hub_dns_rg_name
}
data "azurerm_private_dns_zone" "kv_private_dns" {
  count               = var.pep_manage && var.key_vault_manage ? 1 : 0
  name                = var.kv_private_dns_name
  resource_group_name = local.rg_global_private_dns
}

### application infrastructure ###
module "keyvault_pep" {
  count = var.pep_manage && var.key_vault_manage ? 1 : 0
  providers = {
    azurerm = azurerm.app_svcs
  }
  source               = "../../modules/private_endpoints"
  location             = var.location
  rg_name              = module.keyvault_rg.name
  subnet_endpoint_name = azurerm_subnet.pep.name
  pep_name             = local.keyvault_pep_name
  pep_manual_conn      = var.keyvault_pep_manual_conn
  private_conn_name    = module.keyvault[0].name
  private_conn_id      = module.keyvault[0].id
  network_rg_name      = module.network_rg.name
  pep_vnet_name        = format(local.aks_vnets_name, 0)
  subresource_names    = var.keyvault_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.kv_private_dns[count.index].id
  depends_on = [
    azurerm_subnet.pep
  ]
}

### internal infrastructure ###
module "keyvault_pep_internal" {
  count = var.pep_manage && var.key_vault_manage ? 1 : 0
  providers = {
    azurerm = azurerm.ede_svcs
  }
  source               = "../../modules/private_endpoints"
  location             = var.internal_location
  rg_name              = var.internal_pep_rg_name
  subnet_endpoint_name = var.internal_pep_subnet_name
  pep_name             = join("-", [local.keyvault_pep_name, var.internal_name])
  pep_manual_conn      = var.keyvault_pep_manual_conn
  private_conn_name    = join("-", [module.keyvault[0].name, var.internal_name])
  private_conn_id      = module.keyvault[0].id
  network_rg_name      = var.internal_network_rg_name
  pep_vnet_name        = var.internal_pep_vnet_name
  subresource_names    = var.keyvault_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.kv_internal_private_dns[count.index].id
}
