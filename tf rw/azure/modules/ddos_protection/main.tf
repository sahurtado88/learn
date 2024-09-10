resource "azurerm_network_ddos_protection_plan" "ddos" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
}
