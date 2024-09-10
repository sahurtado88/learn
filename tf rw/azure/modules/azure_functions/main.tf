resource "azurerm_service_plan" "service_plan" {
  name                = var.service_plan_name
  resource_group_name = var.rg_name
  location            = var.location
  os_type             = var.service_plan_os_type
  sku_name            = var.service_plan_sku_name
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_linux_function_app" "function_app" {
  name                = var.function_app_name
  resource_group_name = var.rg_name
  location            = var.location

  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  service_plan_id            = azurerm_service_plan.service_plan.id

  https_only = var.https_only
  site_config {
    always_on                              = var.always_on
    application_insights_connection_string = var.application_insights_connection_string
    application_insights_key               = var.application_insights_key
    # api_management_api_id                  = var.api_management_api_id
    vnet_route_all_enabled = true
    application_stack {
      node_version = var.application_stack_node_version
    }
  }

  app_settings = {
    DATABASE                   = var.app_settings_database
    COSMOSDB_CONNECTION_STRING = var.connection_strings[0]
    # CERTIFICATE_THUMBPRINT     = var.certificate_thumbprint
    TIMERCLOCK                     = var.timer_clock
    TIMERCLOCKSYNC                 = var.timer_clock_sync
    ENABLE_ORYX_BUILD              = var.remote_build
    SCM_DO_BUILD_DURING_DEPLOYMENT = var.remote_build
    WEBSITE_RUN_FROM_PACKAGE       = var.remote_build ? 0 : 1
  }

  connection_string {
    name  = "Cosmosdb"
    type  = "Custom"
    value = var.connection_strings[0]
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [tags, app_settings]
  }
  virtual_network_subnet_id = var.azurerm_subnet_id
}

#Alerts created for Function

locals {
  alert_name_critical = "${var.env_prefix}-${var.env_name}-Critical-Infra"
  alert_name_warning  = "${var.env_prefix}-${var.env_name}-Warning-Infra"
  severity_0          = "0"
  severity_2          = "2"
}

data "azurerm_monitor_action_group" "general" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.env_prefix}-${var.env_name}-agn-alerts-General"
  resource_group_name = "ftds-monitoring-alerts"
}

resource "azurerm_monitor_metric_alert" "memory_working_set_2_5" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.memory_working_set}-${var.function_app_name}-${local.alert_name_critical}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_linux_function_app.function_app.id]
  description         = var.descrip_memory_working_set
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_average
    metric_name      = var.metric_name_working_memory_set
    metric_namespace = "Microsoft.Web/sites"
    operator         = var.operator_generic
    threshold        = var.threshold_2_5g
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.general[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "memory_working_set_2" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.memory_working_set}-${var.function_app_name}-${local.alert_name_warning}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_linux_function_app.function_app.id]
  description         = var.descrip_memory_working_set
  severity            = local.severity_2
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_average
    metric_name      = var.metric_name_working_memory_set
    metric_namespace = "Microsoft.Web/sites"
    operator         = var.operator_generic
    threshold        = var.threshold_2g
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.general[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "http5" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.http5}-${var.function_app_name}-${local.alert_name_critical}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_linux_function_app.function_app.id]
  description         = var.descrip_http5
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_total
    metric_name      = var.metric_name_http5
    metric_namespace = "Microsoft.Web/sites"
    operator         = var.operator_generic
    threshold        = var.threshold_1
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.general[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "http_response_time" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.http_response_time}-${var.function_app_name}-${local.alert_name_critical}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_linux_function_app.function_app.id]
  description         = var.descrip_http_response_time
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_average
    metric_name      = var.metric_name_http_response_time
    metric_namespace = "Microsoft.Web/sites"
    operator         = var.operator_generic
    threshold        = var.threshold_5
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.general[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "request_queue" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.response_queue}-${var.function_app_name}-${local.alert_name_critical}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_linux_function_app.function_app.id]
  description         = var.descrip_http_response_queue
  severity            = local.severity_2
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_average
    metric_name      = var.metric_name_http_response_queue
    metric_namespace = "Microsoft.Web/sites"
    operator         = var.operator_generic
    threshold        = var.threshold_5
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.general[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "file_system" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.file_system}-${var.function_app_name}-${local.alert_name_critical}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_linux_function_app.function_app.id]
  description         = var.descrip_file_system
  severity            = local.severity_0
  frequency           = var.frequency_file_system
  window_size         = var.window_size_file_system
  criteria {
    aggregation      = var.aggregation_average
    metric_name      = var.metric_file_system
    metric_namespace = "Microsoft.Web/sites"
    operator         = var.operator_generic
    threshold        = var.threshold_2g
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.general[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}
