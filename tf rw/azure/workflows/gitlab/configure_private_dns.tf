

data "azurerm_private_dns_zone" "redis_internal_private_dns" {
  count               = var.gitlab_manage && var.pep_manage ? 1 : 0
  provider            = azurerm.hub_dns
  name                = var.redis_dns_zone_name
  resource_group_name = var.hub_dns_rg_name
}
data "azurerm_private_dns_zone" "postgres_internal_private_dns" {
  count               = var.gitlab_manage && var.pep_manage ? 1 : 0
  provider            = azurerm.hub_dns
  name                = var.postgres_private_dns_name
  resource_group_name = var.hub_dns_rg_name
}
data "azurerm_private_dns_zone" "sa_blob_internal_private_dns" {
  count               = var.gitlab_manage && var.pep_manage ? 1 : 0
  provider            = azurerm.hub_dns
  name                = var.sa_blob_private_dns_name
  resource_group_name = var.hub_dns_rg_name
}
data "azurerm_private_dns_zone" "sa_queue_internal_private_dns" {
  count               = var.gitlab_manage && var.pep_manage ? 1 : 0
  provider            = azurerm.hub_dns
  name                = var.sa_queue_private_dns_name
  resource_group_name = var.hub_dns_rg_name
}
data "azurerm_resource_group" "bootstrap_resource_group_private_dns" {
  name = local.rg_private_dns
}
module "redis_private_dns_zone" {
  count         = var.gitlab_manage ? 1 : 0
  source        = "../../modules/private_dns_zone"
  dns_zone_name = var.redis_private_dns_name
  rg_name       = data.azurerm_resource_group.bootstrap_resource_group_private_dns.name
}
module "postgres_private_dns_zone" {
  count         = var.gitlab_manage ? 1 : 0
  source        = "../../modules/private_dns_zone"
  dns_zone_name = var.postgres_private_dns_name
  rg_name       = data.azurerm_resource_group.bootstrap_resource_group_private_dns.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "redis_dns_vnet_link" {
  count                 = var.gitlab_manage ? 1 : 0
  name                  = "link-redis-${local.rg_network}"
  resource_group_name   = data.azurerm_resource_group.bootstrap_resource_group_private_dns.name
  private_dns_zone_name = module.redis_private_dns_zone[count.index].name
  virtual_network_id    = data.azurerm_virtual_network.common_vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres_dns_vnet_link" {
  count                 = var.gitlab_manage ? 1 : 0
  name                  = "link-pg-${local.rg_network}"
  resource_group_name   = data.azurerm_resource_group.bootstrap_resource_group_private_dns.name
  private_dns_zone_name = module.postgres_private_dns_zone[count.index].name
  virtual_network_id    = data.azurerm_virtual_network.common_vnet.id
}
