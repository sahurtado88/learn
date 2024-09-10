

data "azurerm_resource_group" "firewall_rg" {
  name = var.firewall_rg
}

resource "azurerm_public_ip" "firewall_public_ip" {
  name                = var.firewall_public_ip
  location            = data.azurerm_resource_group.firewall_rg.location
  resource_group_name = data.azurerm_resource_group.firewall_rg.name
  allocation_method   = var.fw_public_ip_allocation_method
  sku                 = var.fw_public_ip_sku
}

resource "azurerm_subnet" "firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  virtual_network_name = var.firewall_vnet
  resource_group_name  = data.azurerm_resource_group.firewall_rg.name
  address_prefixes     = [var.firewall_subnet_address_prefixes]

  # route_table_id = azurerm_route_table.firewall_routetable.id
}

resource "azurerm_firewall" "fw" {
  name                = var.firewall_name
  location            = data.azurerm_resource_group.firewall_rg.location
  resource_group_name = data.azurerm_resource_group.firewall_rg.name
  sku_name            = var.fw_sku_name
  sku_tier            = var.fw_sku_tier

  ip_configuration {
    name                 = var.fw_ip_configuration
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }
}

