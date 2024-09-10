# data "azurerm_subnet" "internal_aks_subnet" {
#   provider             = azurerm.ede_svcs
#   name                 = "subnet-aks"
#   virtual_network_name = "vnet-0188-01-centralus"
#   resource_group_name  = "rg-0188-network-centralus"
# }
data "azurerm_virtual_network" "common_vnet" {
  name                = format(local.aks_vnets_name, 0)
  resource_group_name = module.network_rg.name
  depends_on = [
    azurerm_virtual_network.aks_vnets
  ]
}

resource "azurerm_virtual_network" "aks_vnets" {
  count               = floor((var.env_max_clusters) / 4)
  name                = format(local.aks_vnets_name, count.index)
  location            = var.location
  resource_group_name = module.network_rg.name
  address_space       = ["10.${(count.index * 2) + (var.env_index * (floor((var.env_max_clusters - 1) / 20) + 1) * 10)}.0.0/15"]
  dynamic "ddos_protection_plan" {
    for_each = var.global_ddos_manage ? [1] : []
    content {
      id     = data.azurerm_network_ddos_protection_plan.ddos_protection[0].id
      enable = var.global_ddos_manage
    }
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "pep" {
  name                                          = local.pep_subnet_name
  resource_group_name                           = module.network_rg.name
  virtual_network_name                          = data.azurerm_virtual_network.common_vnet.name
  address_prefixes                              = ["10.${var.env_index * (floor((var.env_max_clusters - 1) / 20) + 1) * 10}.96.0/21"] # new
  private_endpoint_network_policies_enabled     = true
  private_link_service_network_policies_enabled = true
  service_endpoints                             = var.service_endpoints
}

# environment peering
resource "azurerm_virtual_network_peering" "base_vnet_peering" {
  count                     = floor((var.env_max_clusters) / 4) - 1
  name                      = format(local.base_vnet_peering, count.index + 1)
  resource_group_name       = module.network_rg.name
  virtual_network_name      = azurerm_virtual_network.aks_vnets[count.index + 1].name
  remote_virtual_network_id = azurerm_virtual_network.aks_vnets[0].id
}
resource "azurerm_virtual_network_peering" "common_vnet_peering" {
  count                     = floor((var.env_max_clusters) / 4) - 1
  name                      = format(local.common_vnet_peering, count.index + 1)
  resource_group_name       = module.network_rg.name
  virtual_network_name      = azurerm_virtual_network.aks_vnets[0].name
  remote_virtual_network_id = azurerm_virtual_network.aks_vnets[count.index + 1].id
}

# global peering
data "azurerm_virtual_network" "global_vnet" {
  name                = local.global_vnet_name
  resource_group_name = local.rg_global
}
resource "azurerm_virtual_network_peering" "local_vnet_peering" {
  count                     = var.global_peering ? floor((var.env_max_clusters) / 4) : 0
  name                      = format(local.local_vnet_peering, count.index)
  resource_group_name       = module.network_rg.name
  virtual_network_name      = azurerm_virtual_network.aks_vnets[count.index].name
  remote_virtual_network_id = data.azurerm_virtual_network.global_vnet.id
}
resource "azurerm_virtual_network_peering" "global_vnet_peering" {
  count                     = var.global_peering ? floor((var.env_max_clusters) / 4) : 0
  name                      = format(local.global_vnet_peering, count.index)
  resource_group_name       = data.azurerm_virtual_network.global_vnet.resource_group_name
  virtual_network_name      = data.azurerm_virtual_network.global_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.aks_vnets[count.index].id
}