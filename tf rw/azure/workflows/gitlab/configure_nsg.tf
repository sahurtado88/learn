module "nsg" {
  count                     = var.common_manage_firewall ? 1 : 0
  source                    = "../../modules/azure_nsg"
  network_security_group_rg = local.rg_general
  # location                            = var.location
  nsg_name                            = var.nsg_name
  nsg_rule                            = var.nsg_rule
  nsg_rule_priority_num               = var.nsg_rule_priority_num
  nsg_rule_direction                  = var.nsg_rule_direction
  nsg_rule_access                     = var.nsg_rule_access
  nsg_rule_protocol                   = var.nsg_rule_protocol
  nsg_rule_source_port_range          = var.nsg_rule_source_port_range
  nsg_rule_destination_port_range     = var.nsg_rule_destination_port_range
  nsg_rule_source_address_prefix      = var.nsg_rule_source_address_prefix
  nsg_rule_destination_address_prefix = var.nsg_rule_destination_address_prefix
}
