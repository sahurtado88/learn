data "azurerm_private_dns_zone" "kv_internal_private_dns" {
  count               = var.pep_manage && var.key_vault_manage ? 1 : 0
  provider            = azurerm.hub_dns
  name                = var.kv_private_dns_name
  resource_group_name = var.hub_dns_rg_name
}

# data "azurerm_subnet" "pep" {
#   provider             = azurerm.app_svcs
#   name                 = azurerm_subnet.pep.name
#   resource_group_name  = module.network_rg.name
#   virtual_network_name = format(local.aks_vnets_name, 0)
# }
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
  network_rg_name      = module.global_rg.name
  # pep_vnet_name    = azurerm_virtual_network.pep_vnet.name
  pep_vnet_name = local.global_vnet_name
  # pep_vnet_name     = data.azurerm_subnet.pep.virtual_network_name
  subresource_names = var.keyvault_subresource_names
  private_zone_id   = module.kv_priv_dns_zone.id
  # pep_subnet_id     = data.azurerm_subnet.pep.id
  depends_on = [
    azurerm_subnet.pep,
    module.kv_priv_dns_zone,
    module.functions_pep_internal
  ]

}

# data "azurerm_subnet" "pep_internal" {
#   provider             = azurerm.ede_svcs
#   name                 = var.internal_pep_subnet_name
#   resource_group_name  = var.internal_network_rg_name
#   virtual_network_name = var.internal_pep_vnet_name
# }
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
  # pep_subnet_id        = data.azurerm_subnet.pep_internal.id
  depends_on = [
    module.keyvault_pep
  ]
}
