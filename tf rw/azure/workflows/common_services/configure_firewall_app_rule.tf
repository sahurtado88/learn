locals {
  fw_app_rule_collection      = "${var.env_prefix}-${var.env_name}-app-collection"
  fw_app_rule_collection_rule = "${var.env_prefix}-${var.env_name}-app-collection-rule"
}
module "firewall_app_rule" {
  count  = var.common_manage_firewall ? 1 : 0
  source = "../../modules/azure_firewall_app_rule"

  firewall_name                                = module.firewall[0].firewall_name
  firewall_rg                                  = local.rg_network
  fw_app_rule_collection                       = local.fw_app_rule_collection
  fw_app_rule_collection_rule                  = local.fw_app_rule_collection_rule
  fw_app_rule_collection_priority              = var.fw_app_rule_collection_priority
  fw_app_rule_collection_action                = var.fw_app_rule_collection_action
  fw_app_rule_collection_rule_source_addresses = var.fw_app_rule_collection_rule_source_addresses
  fw_app_rule_collection_rule_target_fqdns     = var.fw_app_rule_collection_rule_target_fqdns
  fw_app_rule_collection_rule_protocol_port    = var.fw_app_rule_collection_rule_protocol_port
  fw_app_rule_collection_rule_protocol_type    = var.fw_app_rule_collection_rule_protocol_type

}
