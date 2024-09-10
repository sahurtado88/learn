locals {
  alert_name    = "${var.env_prefix}-${var.env_name}-agn-alerts-${var.actiongroup_suffix}"
  enable_common = var.alert_subs ? true : false
}

resource "azurerm_monitor_action_group" "pagerduty" {
  name                = local.alert_name
  resource_group_name = var.actiongroup_rg
  short_name          = substr("agn-${var.actiongroup_suffix}", 0, 12)
  webhook_receiver {
    name                    = local.alert_name
    service_uri             = var.webhook_service_uri
    use_common_alert_schema = local.enable_common
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

