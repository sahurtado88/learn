
resource "azurerm_firewall_network_rule_collection" "network-rule-collection" {
  name                = var.fw_network_rule_collection
  azure_firewall_name = var.firewall_name
  resource_group_name = var.firewall_rg
  priority            = var.fw_network_rule_collection_priority
  action              = var.fw_network_rule_collection_action

  rule {
    name                  = var.fw_network_rule_collection_rule
    source_addresses      = var.fw_network_rule_source_addresses
    destination_ports     = var.fw_network_rule_destination_ports
    destination_addresses = var.fw_network_rule_destination_addresses
    protocols             = var.fw_network_rule_protocols
  }
}

