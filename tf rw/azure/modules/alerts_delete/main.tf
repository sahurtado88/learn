locals {
  alert_name = "Alert-${var.label_operation_name} ${var.alert_name_suffix} Event-Critical-Infra-${var.env_name}"
}

resource "azurerm_monitor_activity_log_alert" "components_delete" {
  name                = local.alert_name
  resource_group_name = var.rg_name_delete
  scopes              = [var.subscription_id]
  description         = "${var.label_operation_name} ${var.alert_name_suffix}-${var.env_name}"
  criteria {
    category       = var.category
    operation_name = var.operation_name
  }
  action {
    action_group_id = var.action_group_id

    webhook_properties = {
        description =  "${var.label_operation_name} ${var.alert_name_suffix}-${var.env_name}"
    }
  }
  lifecycle {
    ignore_changes = [tags]
  }
}
