locals {
  firewall_name = "${var.env_prefix}-${var.env_name}-firewall"
  # firewall_subnet     = "${var.env_prefix}-${var.env_name}-firewall-subnet"
  fw_ip_configuration = "${var.env_prefix}-${var.env_name}-ip-configuration"
  firewall_public_ip  = "${var.env_prefix}-${var.env_name}-public-ip"
}
module "firewall" {
  count  = var.common_manage_firewall ? 1 : 0
  source = "../../modules/azure_firewall"
  # location                         = var.location
  firewall_vnet = local.aks_vnet_name
  firewall_name = local.firewall_name
  # firewall_subnet                  = local.firewall_subnet
  firewall_subnet_address_prefixes = "10.${var.env_index * (floor((var.env_max_clusters - 1) / 20) + 1) * 10}.64.128/25"
  firewall_rg                      = local.rg_network
  fw_ip_configuration              = local.fw_ip_configuration
  firewall_public_ip               = local.firewall_public_ip
  fw_public_ip_sku                 = var.fw_public_ip_sku
  fw_public_ip_allocation_method   = var.fw_public_ip_allocation_method
}
