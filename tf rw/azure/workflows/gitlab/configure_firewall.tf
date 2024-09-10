module "firewall" {
  count         = var.common_manage_firewall ? 1 : 0
  source        = "../../modules/azure_firewall"
  firewall_vnet = data.azurerm_virtual_network.common_vnet.name
  # tags                             = var.tags
  # location        = var.location
  firewall_name = var.firewall_name
  # firewall_subnet = var.firewall_subnet
  firewall_subnet_address_prefixes = "10.245.64.128/25"
  firewall_rg                      = local.rg_network
  fw_ip_configuration              = var.fw_ip_configuration
  fw_public_ip_sku                 = var.fw_public_ip_sku
  fw_public_ip_allocation_method   = var.fw_public_ip_allocation_method
  firewall_public_ip               = var.firewall_public_ip
  # depends_on = [
  #   module.common_network_rg
  # ]
}
