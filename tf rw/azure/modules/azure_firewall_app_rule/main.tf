
resource "azurerm_firewall_application_rule_collection" "app-rule-collection" {
  name                = var.fw_app_rule_collection
  azure_firewall_name = var.firewall_name
  resource_group_name = var.firewall_rg
  priority            = var.fw_app_rule_collection_priority
  action              = var.fw_app_rule_collection_action

  rule {
    name = var.fw_app_rule_collection_rule

    source_addresses = var.fw_app_rule_collection_rule_source_addresses
    target_fqdns     = var.fw_app_rule_collection_rule_target_fqdns

    protocol {
      port = var.fw_app_rule_collection_rule_protocol_port
      type = var.fw_app_rule_collection_rule_protocol_type
    }
  }
}
