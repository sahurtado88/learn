data "azurerm_private_dns_zone" "redis_internal_private_dns" {
  count               = var.gitlab_manage && var.pep_manage ? 1 : 0
  provider            = azurerm.hub_dns
  name                = var.redis_dns_zone_name
  resource_group_name = var.hub_dns_rg_name
}

data "azurerm_private_dns_zone" "redis_private_dns" {
  count               = var.gitlab_manage && var.pep_manage ? 1 : 0
  name                = var.redis_dns_zone_name
  resource_group_name = local.rg_private_dns
}
data "azurerm_private_dns_zone" "postgresql_private_dns" {
  count               = var.gitlab_manage && var.pep_manage ? 1 : 0
  name                = var.postgres_private_dns_name
  resource_group_name = local.rg_private_dns
}
data "azurerm_private_dns_zone" "sa_blob_internal_private_dns" {
  count               = var.gitlab_manage && var.pep_manage ? 1 : 0
  provider            = azurerm.hub_dns
  name                = var.sa_blob_private_dns_name
  resource_group_name = var.hub_dns_rg_name
}
data "azurerm_private_dns_zone" "sa_blob_private_dns" {
  count               = var.gitlab_manage && var.pep_manage ? 1 : 0
  name                = var.sa_blob_private_dns_name
  resource_group_name = local.rg_private_dns
}