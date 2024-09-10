resource "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                       = var.cosmosdb_account_name
  location                   = var.cosmosdb_account_location
  resource_group_name        = var.cosmosdb_account_resource_group_name
  offer_type                 = "Standard"
  kind                       = "MongoDB"
  analytical_storage_enabled = var.analytical_storage_enabled

  enable_automatic_failover             = true
  public_network_access_enabled         = var.public_network_access_enabled
  network_acl_bypass_for_azure_services = true
  is_virtual_network_filter_enabled     = true
  mongo_server_version                  = "4.2"

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  capabilities {
    name = "EnableMongo"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = var.failover_location
    failover_priority = 1
  }

  geo_location {
    location          = var.cosmosdb_account_location
    failover_priority = 0
  }
  backup {
    type = var.backup_type
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

#Alerts created for CosmosDB

locals {
  alert_name_critical = "${var.env_prefix}-${var.env_name}-Critical-Infra"
  alert_name_warning  = "${var.env_prefix}-${var.env_name}-Warning-Infra"
  severity_0          = "0"
  severity_2          = "2"
}

data "azurerm_monitor_action_group" "dbs" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.env_prefix}-${var.env_name}-agn-alerts-DBs"
  resource_group_name = "ftds-monitoring-alerts"
}

resource "azurerm_monitor_metric_alert" "availability" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.availability}-${var.cosmosdb_account_name}-${local.alert_name_critical}"
  resource_group_name = var.cosmosdb_account_resource_group_name
  scopes              = [azurerm_cosmosdb_account.cosmosdb_account.id]
  description         = var.descrip_availability
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size_availability
  criteria {
    aggregation      = var.aggregation
    metric_name      = var.metric_name_availability
    metric_namespace = "Microsoft.DocumentDB/DatabaseAccounts"
    operator         = var.operator_lessthan
    threshold        = var.threshold_availability
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.dbs[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "latency" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.latency}-${var.cosmosdb_account_name}-${local.alert_name_critical}"
  resource_group_name = var.cosmosdb_account_resource_group_name
  scopes              = [azurerm_cosmosdb_account.cosmosdb_account.id]
  description         = var.descrip_latency
  severity            = local.severity_2
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation
    metric_name      = var.metric_name_latency
    metric_namespace = "Microsoft.DocumentDB/DatabaseAccounts"
    operator         = var.operator_greaterthan
    threshold        = var.threshold_latency
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.dbs[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "throughput_critical" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.throughput}-${var.cosmosdb_account_name}-${local.alert_name_critical}"
  resource_group_name = var.cosmosdb_account_resource_group_name
  scopes              = [azurerm_cosmosdb_account.cosmosdb_account.id]
  description         = var.descrip_throughput
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation
    metric_name      = var.metric_name_throughput
    metric_namespace = "Microsoft.DocumentDB/DatabaseAccounts"
    operator         = var.operator_greaterthan
    threshold        = var.threshold_throughput_critical
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.dbs[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "throughput_warning" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.throughput}-${var.cosmosdb_account_name}-${local.alert_name_warning}"
  resource_group_name = var.cosmosdb_account_resource_group_name
  scopes              = [azurerm_cosmosdb_account.cosmosdb_account.id]
  description         = var.descrip_throughput
  severity            = local.severity_2
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation
    metric_name      = var.metric_name_throughput
    metric_namespace = "Microsoft.DocumentDB/DatabaseAccounts"
    operator         = var.operator_greaterthan
    threshold        = var.threshold_throughput_warning
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.dbs[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}
