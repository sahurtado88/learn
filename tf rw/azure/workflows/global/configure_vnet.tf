resource "azurerm_virtual_network" "global_vnet" {
  name                = local.global_vnet_name
  location            = var.location
  resource_group_name = module.global_rg.name
  address_space       = [var.global_vnet_address]
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
  name                                          = local.global_pep_subnet_name
  resource_group_name                           = azurerm_virtual_network.global_vnet.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.global_vnet.name
  address_prefixes                              = ["10.245.96.0/21"]
  private_endpoint_network_policies_enabled     = true
  private_link_service_network_policies_enabled = true
  service_endpoints                             = var.service_endpoints
}