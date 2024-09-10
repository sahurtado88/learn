module "search_service_private_dns" {
  count         = var.pep_manage ? 1 : 0
  source        = "../../modules/private_dns_zone"
  dns_zone_name = var.search_service_private_dns
  rg_name       = data.azurerm_resource_group.private_dns_rg[count.index].name
  depends_on = [
    azurerm_search_service.embeddings
  ]
}

module "cognitive_services_private_dns" {
  count         = var.pep_manage ? 1 : 0
  source        = "../../modules/private_dns_zone"
  dns_zone_name = var.cognitive_services_private_dns
  rg_name       = data.azurerm_resource_group.private_dns_rg[count.index].name
  depends_on = [
    azurerm_cognitive_account.ai
  ]
}

data "azurerm_private_dns_zone" "cognitive_services_internal_private_dns" {
  count               = var.pep_manage ? 1 : 0
  provider            = azurerm.hub_dns
  name                = var.cognitive_services_private_dns
  resource_group_name = var.hub_dns_rg_name
}

data "azurerm_private_dns_zone" "search_service_internal_private_dns" {
  count               = var.pep_manage ? 1 : 0
  provider            = azurerm.hub_dns
  name                = var.search_service_private_dns
  resource_group_name = var.hub_dns_rg_name
}
