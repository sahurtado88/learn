# resource "azurerm_virtual_network" "tfstate_vnet" {
#   name                = var.tfstate_vnet_name
#   location            = var.location
#   resource_group_name = var.tfstate_rg_name
#   address_space       = [var.tfstate_vnet_address]
# }

# resource "azurerm_subnet" "tfstate_subnet" {
#   name                                           = var.tfstate_subnet_name
#   resource_group_name                            = azurerm_virtual_network.tfstate_vnet.resource_group_name
#   virtual_network_name                           = azurerm_virtual_network.tfstate_vnet.name
#   address_prefixes                               = [var.tfstate_subnet_address_prefixes]
#   enforce_private_link_endpoint_network_policies = true
#   enforce_private_link_service_network_policies  = true
#   service_endpoints                              = ["Microsoft.Storage"]
# }
