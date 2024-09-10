resource "azurerm_postgresql_server" "pg" {
  name                = var.pg_name
  location            = var.location
  resource_group_name = var.rg_name

  sku_name = var.pg_sku

  storage_mb                    = var.pg_storage
  backup_retention_days         = var.pg_backup_retention_days
  geo_redundant_backup_enabled  = var.pg_geo_redundant
  public_network_access_enabled = var.public_network_access_enabled

  administrator_login              = var.pg_admin_username
  administrator_login_password     = var.pg_admin_password
  version                          = var.pg_version
  ssl_enforcement_enabled          = var.pg_ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.pg_ssl_minimal_tls_version_enforced
  lifecycle {
    ignore_changes = [tags]
  }
  # There is no resource to add a read-only replica. However, we can
  # theoretically use provisioners to create the replica as documented
  # here. However, it it advisible not to use provisioners. Therefore,
  # for the moment until we find out what is the best way to handle this,
  # punting it. -SS
  #
  # https://registry.terraform.io/modules/booyaa/postgresql-read-replica/azurerm/latest
  # https://github.com/booyaa/terraform-azurerm-postgresql-read-replica
}

resource "azurerm_postgresql_database" "pgdb" {
  count               = length(var.pg_db_names)
  name                = var.pg_db_names[count.index]
  resource_group_name = var.rg_name
  server_name         = azurerm_postgresql_server.pg.name
  charset             = var.pg_charset
  collation           = var.pg_collation
  depends_on = [
    azurerm_postgresql_server.pg,
  ]
}

resource "azurerm_postgresql_configuration" "config" {
  name                = "log_disconnections"
  resource_group_name = var.rg_name
  server_name         = azurerm_postgresql_server.pg.name
  value               = "on"
}

#Alerts created for Postgres

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

data "azurerm_monitor_action_group" "security" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.env_prefix}-${var.env_name}-agn-alerts-Security"
  resource_group_name = "ftds-monitoring-alerts"
}


resource "azurerm_monitor_metric_alert" "connection_failed" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.connection_failed}-${var.pg_name}-${local.alert_name_critical}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_postgresql_server.pg.id]
  description         = var.descrip_connection_failed
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_total
    metric_name      = var.metric_name_connection_failed
    metric_namespace = "Microsoft.DBforPostgreSQL/servers"
    operator         = var.operator
    threshold        = var.threshold_10
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

resource "azurerm_monitor_metric_alert" "cpu_percent_90" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.cpu_percent}-${var.pg_name}-${local.alert_name_critical}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_postgresql_server.pg.id]
  description         = var.descrip_cpu_percent
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_average
    metric_name      = var.metric_name_cpu_percent
    metric_namespace = "Microsoft.DBforPostgreSQL/servers"
    operator         = var.operator
    threshold        = var.threshold_90
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

resource "azurerm_monitor_metric_alert" "cpu_percent_80" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.cpu_percent}-${var.pg_name}-${local.alert_name_warning}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_postgresql_server.pg.id]
  description         = var.descrip_cpu_percent
  severity            = local.severity_2
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_average
    metric_name      = var.metric_name_cpu_percent
    metric_namespace = "Microsoft.DBforPostgreSQL/servers"
    operator         = var.operator
    threshold        = var.threshold_80
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

resource "azurerm_monitor_metric_alert" "memory_percent_90" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.memory_percent}-${local.alert_name_critical}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_postgresql_server.pg.id]
  description         = var.descrip_memory_percent
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_average
    metric_name      = var.metric_name_memory_percent
    metric_namespace = "Microsoft.DBforPostgreSQL/servers"
    operator         = var.operator
    threshold        = var.threshold_90
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

resource "azurerm_monitor_metric_alert" "memory_percent_80" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.memory_percent}-${local.alert_name_warning}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_postgresql_server.pg.id]
  description         = var.descrip_memory_percent
  severity            = local.severity_2
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_average
    metric_name      = var.metric_name_memory_percent
    metric_namespace = "Microsoft.DBforPostgreSQL/servers"
    operator         = var.operator
    threshold        = var.threshold_80
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

resource "azurerm_monitor_metric_alert" "storage_percent_90" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.storage_percent}-${local.alert_name_critical}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_postgresql_server.pg.id]
  description         = var.descrip_storage_percent
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_average
    metric_name      = var.metric_name_storage_percent
    metric_namespace = "Microsoft.DBforPostgreSQL/servers"
    operator         = var.operator
    threshold        = var.threshold_90
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

resource "azurerm_monitor_metric_alert" "storage_percent_80" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.storage_percent}-${local.alert_name_warning}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_postgresql_server.pg.id]
  description         = var.descrip_storage_percent
  severity            = local.severity_2
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_average
    metric_name      = var.metric_name_storage_percent
    metric_namespace = "Microsoft.DBforPostgreSQL/servers"
    operator         = var.operator
    threshold        = var.threshold_80
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

# Activity log alert for create / update sql server firewall rule
resource "azurerm_monitor_activity_log_alert" "create_or_update_firewall_rule" {
  count               = var.alerts_manage ? 1 : 0
  name                = "Firewall Rule Created or Updated ${local.alert_name_warning}"
  resource_group_name = var.rg_name
  scopes              = [azurerm_postgresql_server.pg.id]
  criteria {
    category       = var.category
    operation_name = var.operation_name_firewall_rule
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
