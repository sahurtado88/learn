module "redis_pep" {
  count                = var.gitlab_manage && var.pep_manage ? 1 : 0
  source               = "../../modules/private_endpoints"
  location             = var.location
  rg_name              = local.rg_general
  subnet_endpoint_name = local.pep_subnet_name
  pep_name             = local.redis_pep_name
  pep_manual_conn      = var.redis_pep_manual_conn
  private_conn_name    = azurerm_redis_cache.redis_cache[0].name
  private_conn_id      = azurerm_redis_cache.redis_cache[0].id
  network_rg_name      = local.rg_network
  pep_vnet_name        = data.azurerm_virtual_network.common_vnet.name
  subresource_names    = var.redis_subresource_names
  // private_zone_id      = module.redis_private_dns_zone[count.index].id
  private_zone_id = data.azurerm_private_dns_zone.redis_private_dns[count.index].id
  depends_on = [
    azurerm_redis_cache.redis_cache
  ]
}

module "sa_gitlab_pep" {
  count                = var.gitlab_manage && var.pep_manage ? 1 : 0
  source               = "../../modules/private_endpoints"
  location             = var.location
  rg_name              = local.rg_general
  subnet_endpoint_name = local.pep_subnet_name
  pep_name             = local.sa_gitlab_pep_name
  pep_manual_conn      = var.sa_gl_pep_manual_conn
  private_conn_name    = module.global_storage_account.storage_name
  private_conn_id      = module.global_storage_account.storage_id
  network_rg_name      = local.rg_network
  pep_vnet_name        = data.azurerm_virtual_network.common_vnet.name
  subresource_names    = var.sa_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.sa_mon_blob_private_dns[count.index].id
  depends_on = [
    module.global_storage_account.name,
    module.redis_pep_internal # Because parallel PEP creation fails
  ]
}
//data "azurerm_private_dns_zone" "sa_blob_private_dns" {
//  count               = var.gitlab_manage && var.pep_manage ? 1 : 0
//  name                = var.sa_blob_private_dns_name
//  resource_group_name = local.rg_private_dns
//}

### internal infrastructure ###
module "redis_pep_internal" {
  count = var.gitlab_manage && var.pep_manage ? 1 : 0
  providers = {
    azurerm = azurerm.ede_svcs
  }
  source               = "../../modules/private_endpoints"
  location             = var.internal_location
  rg_name              = var.internal_pep_rg_name
  subnet_endpoint_name = var.internal_pep_subnet_name
  pep_name             = join("-", [local.redis_pep_name, var.internal_name])
  pep_manual_conn      = var.redis_pep_manual_conn
  private_conn_name    = azurerm_redis_cache.redis_cache[0].name
  private_conn_id      = azurerm_redis_cache.redis_cache[0].id
  network_rg_name      = var.internal_network_rg_name
  pep_vnet_name        = var.internal_pep_vnet_name
  subresource_names    = var.redis_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.redis_internal_private_dns[count.index].id
  depends_on = [
    module.redis_pep # Because parallel PEP creation fails
  ]
}
module "sa_gitlab_pep_internal" {
  count = var.gitlab_manage && var.pep_manage ? 1 : 0
  providers = {
    azurerm = azurerm.ede_svcs
  }
  source               = "../../modules/private_endpoints"
  location             = var.internal_location
  rg_name              = var.internal_pep_rg_name
  subnet_endpoint_name = var.internal_pep_subnet_name
  pep_name             = join("-", [local.sa_gitlab_pep_name, var.internal_name])
  pep_manual_conn      = var.sa_gl_pep_manual_conn
  private_conn_name    = module.global_storage_account.storage_name
  private_conn_id      = module.global_storage_account.storage_id
  network_rg_name      = var.internal_network_rg_name
  pep_vnet_name        = var.internal_pep_vnet_name
  subresource_names    = var.sa_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.sa_blob_internal_private_dns[count.index].id
  depends_on = [
    module.sa_gitlab_pep # Because parallel PEP creation fails
  ]
}
