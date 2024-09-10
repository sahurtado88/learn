resource "azurerm_container_registry" "common_acr" {
  name                          = var.acr_name
  resource_group_name           = var.rg_name
  location                      = var.location
  sku                           = var.acr_sku
  admin_enabled                 = var.acr_admin_enabled
  zone_redundancy_enabled       = var.acr_zone_redundancy_enabled
  public_network_access_enabled = var.acr_public_network_enabled
  georeplications {
    location                  = var.location_pair
    zone_redundancy_enabled   = var.georeplications_zone_redundancy_enabled
    regional_endpoint_enabled = var.georeplications_regional_endpoint_enabled
  }
  # network_rule_set = [{
  #   default_action = "Deny"
  #   ip_rule = [{
  #     action   = "Allow"
  #     ip_range = var.network_rule_set_ip_range
  #   }]
  #   virtual_network = [{
  #     action    = "Allow"
  #     subnet_id = var.network_rule_set_subnet_id
  #   }]
  # }]
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

#Alerts created for ACR
locals {
  alert_name_critical = "${var.env_prefix}-${var.env_name}-Critical-Infra"
  alert_name_info     = "${var.env_prefix}-${var.env_name}-Information-Infra"
  severity_2          = "2"
  severity_3          = "3"
}

data "azurerm_monitor_action_group" "acr" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.env_prefix}-${var.env_name}-agn-alerts-AKS"
  resource_group_name = "ftds-monitoring-alerts"
}

resource "azurerm_monitor_metric_alert" "acr_storage_used" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.storage_usage}-${var.acr_name}-${local.alert_name_critical}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_container_registry.common_acr.id]
  description         = var.descrip_storage_used
  severity            = local.severity_2
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_average
    metric_name      = var.metric_name_storage_used
    metric_namespace = "Microsoft.ContainerRegistry/registries"
    operator         = var.operator
    threshold        = var.threshold_storage_used
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.acr[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "acr_run_duration" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.run_duration}-${var.acr_name}-${local.alert_name_info}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_container_registry.common_acr.id]
  description         = var.descrip_run_duratiom
  severity            = local.severity_3
  frequency           = var.frequency
  window_size         = var.window_size_generic
  criteria {
    aggregation      = var.aggregation_total
    metric_name      = var.metric_name_run_duration
    metric_namespace = "Microsoft.ContainerRegistry/registries"
    operator         = var.operator
    threshold        = var.threshold_25
  }
  auto_mitigate = true
  action {
    action_group_id = data.azurerm_monitor_action_group.acr[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "acr_total_pull" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.total_pull_count}-${var.acr_name}-${local.alert_name_info}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_container_registry.common_acr.id]
  description         = var.descrip_total_pull
  severity            = local.severity_3
  frequency           = var.frequency
  window_size         = var.window_size_generic
  criteria {
    aggregation      = var.aggregation_total
    metric_name      = var.metric_name_total_pull_count
    metric_namespace = "Microsoft.ContainerRegistry/registries"
    operator         = var.operator
    threshold        = var.threshold_25
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.acr[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "acr_total_push" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.total_push_count}-${var.acr_name}-${local.alert_name_info}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_container_registry.common_acr.id]
  description         = var.descrip_total_push
  severity            = local.severity_3
  frequency           = var.frequency
  window_size         = var.window_size_generic
  criteria {
    aggregation      = var.aggregation_total
    metric_name      = var.metric_name_total_push_count
    metric_namespace = "Microsoft.ContainerRegistry/registries"
    operator         = var.operator
    threshold        = var.threshold_25
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.acr[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}


