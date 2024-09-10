module "whitelist" {
  source = "../../modules/whitelist"
}

module "waf_common" {
  count                            = var.waf_manage ? 1 : 0
  source                           = "../../modules/web_application_firewall"
  location                         = var.location
  waf_policy_rg_name               = module.waf_policy_rg.name
  fw_policy_name                   = local.fw_policy_name
  waf_policy_enabled               = var.waf_policy_enabled
  waf_policy_mode                  = var.waf_policy_mode
  waf_policy_request_body_check    = var.waf_policy_request_body_check
  waf_policy_file_upload_limit     = var.waf_policy_file_upload_limit
  waf_policy_max_request_body_size = var.waf_policy_max_request_body_size
  whitelist_ip_range               = concat(module.whitelist.whitelist_ip_range, var.whitelist_ip_range)
  rule_group_override              = var.rule_group_override
  # global env in harness may not define monitoring_manage_external_access flag, in each case we are
  # getting a string "null"
  custom_rules_monitoring = var.monitoring_manage_external_access != "null" ? var.monitoring_manage_external_access : false
  custom_rules_whitelist  = true
  montoolsKey             = var.montoolsKey

  depends_on = [
    module.whitelist
  ]
}

module "waf_grafana" {
  count                            = var.waf_grafana_manage ? 1 : 0
  source                           = "../../modules/web_application_firewall"
  location                         = var.location
  waf_policy_rg_name               = module.waf_policy_rg.name
  fw_policy_name                   = local.fw_grafana_policy_name
  waf_policy_enabled               = true
  waf_policy_mode                  = "Prevention"
  waf_policy_request_body_check    = var.waf_policy_request_body_check
  waf_policy_file_upload_limit     = var.waf_policy_file_upload_limit
  waf_policy_max_request_body_size = var.waf_policy_max_request_body_size
  whitelist_ip_range               = concat(module.whitelist.whitelist_ip_range, var.whitelist_ip_range)
  rule_group_override              = var.rule_group_grafana_override
  custom_rules_monitoring          = false
  custom_rules_whitelist           = true
  montoolsKey                      = var.montoolsKey

  depends_on = [
    module.whitelist
  ]
}
