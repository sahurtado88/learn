resource "azurerm_storage_account" "storage" {
  name                            = var.storage_name
  location                        = var.location
  resource_group_name             = var.rg_name
  account_tier                    = "Standard"
  account_replication_type        = var.replication_type
  enable_https_traffic_only       = var.enable_https_traffic_only
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  min_tls_version                 = var.min_tls_version
  lifecycle {
    ignore_changes = [tags, account_replication_type]
  }
}

resource "azurerm_storage_account_network_rules" "network_rules" {
  count              = var.storage_manage_network ? 1 : 0
  storage_account_id = azurerm_storage_account.storage.id
  default_action     = var.storage_network_access
  # virtual_network_subnet_ids = var.storage_subnet_ids
  # ip_rules                   = var.ip_rules
  bypass = var.bypass
}

#Alerts created for SA
locals {
  alert_name_critical = "${var.env_prefix}-${var.env_name}-Critical-Infra"
  alert_name_warning  = "${var.env_prefix}-${var.env_name}-Warning-Infra"
  severity_0          = "0"
  severity_3          = "3"
}

data "azurerm_monitor_action_group" "sa" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.env_prefix}-${var.env_name}-agn-alerts-SA"
  resource_group_name = "ftds-monitoring-alerts"
}

resource "azurerm_monitor_metric_alert" "sa_e2e_latency" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.e2e_latency}-${var.storage_name}-${local.alert_name_warning}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_storage_account.storage.id]
  description         = var.descrip_e2e_latency
  severity            = local.severity_3
  frequency           = var.frequency
  window_size         = var.windows_size
  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = var.metric_name_e2e
    aggregation      = var.aggregation_generic
    operator         = var.operator_generic
    threshold        = var.threshold_e2e
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.sa[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "sa_availability" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.availability}-${var.storage_name}-${local.alert_name_critical}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_storage_account.storage.id]
  description         = var.descrip_availability
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.windows_size
  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = var.metric_name_availability
    aggregation      = var.aggregation_generic
    operator         = var.operator_less
    threshold        = var.threshold_availability
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.sa[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

