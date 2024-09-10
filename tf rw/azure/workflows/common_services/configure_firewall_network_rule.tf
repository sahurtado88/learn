
locals {
  fw_network_rule_collection      = "${var.env_prefix}-${var.env_name}-network-collection"
  fw_network_rule_collection_rule = "${var.env_prefix}-${var.env_name}-network-collection-rule"
}
module "firewall_network_rule" {
  count                                 = var.common_manage_firewall ? 1 : 0
  source                                = "../../modules/azure_firewall_network_rule"
  firewall_name                         = module.firewall[0].firewall_name
  firewall_rg                           = local.rg_network
  fw_network_rule_collection            = local.fw_network_rule_collection
  fw_network_rule_collection_rule       = local.fw_network_rule_collection_rule
  fw_network_rule_collection_priority   = var.fw_network_rule_collection_priority
  fw_network_rule_collection_action     = var.fw_network_rule_collection_action
  fw_network_rule_source_addresses      = var.fw_network_rule_source_addresses
  fw_network_rule_destination_ports     = var.fw_network_rule_destination_ports
  fw_network_rule_destination_addresses = var.fw_network_rule_destination_addresses
  fw_network_rule_protocols             = var.fw_network_rule_protocols

}

