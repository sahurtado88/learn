locals {
  rg_global_private_dns = "${var.env_prefix}-rg-private-dns"
}

data "azurerm_virtual_network" "aks_common_vnet" {
  count               = var.ai_manage ? 1 : 0
  name                = "${var.env_prefix}-${var.env_name}-vnet-000"
  resource_group_name = "${var.env_prefix}-${var.env_name}-rg-network"
}

resource "azurerm_private_dns_zone_virtual_network_link" "cognitive_services_dns_vnet_link" {
  count                 = var.ai_manage ? 1 : 0
  name                  = "link-cognitive-services-${var.env_prefix}-${var.env_name}-vnet-000"
  resource_group_name   = local.rg_global_private_dns
  virtual_network_id    = data.azurerm_virtual_network.aks_common_vnet[count.index].id
  private_dns_zone_name = var.cognitive_services_private_dns
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "search_dns_vnet_link" {
  count                 = var.ai_manage ? 1 : 0
  name                  = "link-search-${var.env_prefix}-${var.env_name}-vnet-000"
  resource_group_name   = local.rg_global_private_dns
  virtual_network_id    = data.azurerm_virtual_network.aks_common_vnet[count.index].id
  private_dns_zone_name = var.search_service_private_dns
  registration_enabled  = false
}
