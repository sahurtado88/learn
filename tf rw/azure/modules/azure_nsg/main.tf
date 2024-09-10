data "azurerm_resource_group" "nsg_rg" {
  name = var.network_security_group_rg
}

resource "azurerm_network_security_group" "nsg_template" {
  name                = var.nsg_name
  location            = data.azurerm_resource_group.nsg_rg.location
  resource_group_name = data.azurerm_resource_group.nsg_rg.name
  security_rule {
    name                       = var.nsg_rule
    priority                   = var.nsg_rule_priority_num
    direction                  = var.nsg_rule_direction
    access                     = var.nsg_rule_access
    protocol                   = var.nsg_rule_protocol
    source_port_range          = var.nsg_rule_source_port_range
    destination_port_range     = var.nsg_rule_destination_port_range
    source_address_prefix      = var.nsg_rule_source_address_prefix
    destination_address_prefix = var.nsg_rule_destination_address_prefix
  }
}
