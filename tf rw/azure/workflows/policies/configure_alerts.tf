#Alerts for Create Policy Assignment

# create or update policy assignment
resource "azurerm_monitor_activity_log_alert" "create_policy_assignment" {
  name                = local.alert_name_pa
  resource_group_name = local.rg_name
  scopes              = [data.azurerm_subscription.current.id]
  criteria {
    category       = var.category
    operation_name = var.operation_name_pa
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.security[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

# Alerts created for Network Security Group

locals {
  alert_name_nsg      = "Alert-Create_or_Update ${var.alert_name_suffix} Network-Security-Group-${var.env_name}"
  alert_name_sec_rule = "Alert-Create_or_Update ${var.alert_name_suffix} Network-Security-Group-Rule-${var.env_name}"
  alert_name_sec_soln = "Alert-Create_or_Update ${var.alert_name_suffix} Security-Solution-${var.env_name}"
}

# create or update NSG
resource "azurerm_monitor_activity_log_alert" "create_or_update_nsg" {
  name                = local.alert_name_nsg
  resource_group_name = local.rg_name
  scopes              = [data.azurerm_subscription.current.id]
  criteria {
    category       = var.category
    operation_name = var.operation_name_nsg
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.security[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

# Create or update security group rule
resource "azurerm_monitor_activity_log_alert" "update_security_group_rule" {
  name                = local.alert_name_sec_rule
  resource_group_name = local.rg_name
  scopes              = [data.azurerm_subscription.current.id]
  criteria {
    category       = var.category
    operation_name = var.operation_name_sec_grp_rule
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.security[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

data "azurerm_monitor_action_group" "security" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.env_prefix}-${var.env_name}-agn-alerts-Security"
  resource_group_name = "ftds-monitoring-alerts"
}

# Activity log alert for create or update security solution in defender for cloud
resource "azurerm_monitor_activity_log_alert" "create_update_security_solution" {
  name                = local.alert_name_sec_soln
  resource_group_name = local.rg_name
  scopes              = [data.azurerm_subscription.current.id]
  criteria {
    category       = var.category
    operation_name = var.operation_name_sec_soln
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.security[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  lifecycle {
    ignore_changes = [tags]
  }
}
