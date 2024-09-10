resource "azurerm_web_application_firewall_policy" "whitelistIp" {
  name                = var.fw_policy_name
  resource_group_name = var.waf_policy_rg_name
  location            = var.location
  # tags                = var.tags

  # Protecting access to monitoring endpoints: only GET requests to loki and prometheus, 
  # with the certain value in "ra-x-montools-key" header.
  # We were not able to implement such logic in a single rule, because of this behaviour: if the rule specifies to
  # block all requests where header X does not match a certain value, the requests without header X are allowed through.
  # Here is a good article describing this and offering the workaround: 
  # https://blog.ivemo.se/WAF-Policy-custom-rules/
  #
  dynamic "custom_rules" {
    for_each = var.custom_rules_monitoring ? [1] : []
    content {
      name      = "MonToolsAllow"
      priority  = 80
      rule_type = "MatchRule"

      match_conditions {
        match_variables {
          variable_name = "RequestHeaders"
          selector      = "ra-x-montools-key"
        }
        operator           = "Equal"
        negation_condition = false
        match_values       = [var.montoolsKey]
      }

      match_conditions {
        match_variables {
          variable_name = "RequestUri"
        }
        operator           = "BeginsWith"
        negation_condition = false
        match_values       = ["/loki/", "/prometheus/"]
      }

      match_conditions {
        match_variables {
          variable_name = "RequestMethod"
        }
        operator           = "Equal"
        negation_condition = false
        match_values       = ["get"]
        transforms         = ["Lowercase"]
      }

      action = "Allow"
    }
  }

  dynamic "custom_rules" {
    for_each = var.custom_rules_monitoring ? [1] : []
    content {
      name      = "MonToolsBlock"
      priority  = 81
      rule_type = "MatchRule"

      match_conditions {
        match_variables {
          variable_name = "RequestUri"
        }
        operator           = "BeginsWith"
        negation_condition = false
        match_values       = ["/loki/", "/prometheus/"]
      }

      action = "Block"
    }
  }

  dynamic "custom_rules" {
    for_each = var.custom_rules_whitelist ? [1] : []
    content {
      name      = "WhitelistIPs"
      priority  = 90
      rule_type = "MatchRule"
      match_conditions {
        match_variables {
          variable_name = "RemoteAddr"
        }
        operator           = "IPMatch"
        negation_condition = false
        match_values       = var.whitelist_ip_range
      }
      action = "Allow"
    }
  }
  dynamic "custom_rules" {
    for_each = var.custom_rules_whitelist ? [1] : []
    content {
      name      = "BlockIPs"
      priority  = 100
      rule_type = "MatchRule"
      match_conditions {
        match_variables {
          variable_name = "RemoteAddr"
        }
        operator           = "IPMatch"
        negation_condition = false
        match_values       = var.block_all_ip_range
      }
      action = "Block"
    }
  }
  dynamic "custom_rules" {
    for_each = var.custom_rules_geolocation ? [1] : []
    content {
      name      = "GeoLocationBlock"
      priority  = 70
      rule_type = "MatchRule"
      match_conditions {
        match_variables {
          variable_name = "RemoteAddr"
        }
        operator           = "GeoMatch"
        negation_condition = false
        match_values       = var.block_countries
      }
      action = "Block"
    }
  }
  policy_settings {
    enabled                     = var.waf_policy_enabled
    mode                        = var.waf_policy_mode
    request_body_check          = var.waf_policy_request_body_check
    file_upload_limit_in_mb     = var.waf_policy_file_upload_limit
    max_request_body_size_in_kb = var.waf_policy_max_request_body_size
  }

  managed_rules {
    dynamic "exclusion" {
      for_each = var.exclusion
      content {
        match_variable          = exclusion.value["match_variable"]
        selector                = exclusion.value["selector"]
        selector_match_operator = exclusion.value["selector_match_operator"]
      }
    }
    managed_rule_set {
      type    = var.managed_rule_set_type
      version = var.managed_rule_set_version
      dynamic "rule_group_override" {
        for_each = var.rule_group_override
        content {
          rule_group_name = rule_group_override.value["rule_group_name"]

          # disabled_rules  = rule_group_override.value["disabled_rules"]
          dynamic "rule" {
            for_each = rule_group_override.value["disabled_rules"]
            content {
              id      = rule.value
              enabled = false
              action  = "AnomalyScoring"
            }
          }
        }
      }
    }
  }
  lifecycle {
    ignore_changes = [tags, custom_rules]
  }
}

