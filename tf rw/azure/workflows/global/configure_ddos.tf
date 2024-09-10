data "azurerm_network_ddos_protection_plan" "ddos_protection" {
  count               = var.global_ddos_manage ? 1 : 0
  provider            = azurerm.ddos_plan
  name                = var.ddos_protection_name
  resource_group_name = var.ddos_protection_rg_name
}
