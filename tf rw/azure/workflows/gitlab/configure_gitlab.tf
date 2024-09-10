
#########################
##   Redis for Gitlab  ##
#########################

resource "azurerm_redis_cache" "redis_cache" {
  count               = var.gitlab_manage ? 1 : 0
  name                = var.common_redis_name
  location            = var.location
  resource_group_name = local.rg_general
  replicas_per_master = var.common_redis_replicas_per_master
  capacity            = var.common_redis_capacity
  family              = var.common_redis_family
  sku_name            = var.common_redis_sku
  enable_non_ssl_port = var.common_redis_enable_non_ssl
  zones               = var.common_redis_zones
  # tags                = var.tags
}

#Alerts created for RedisCache

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

resource "azurerm_monitor_metric_alert" "errors" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.errors}-${local.alert_name_critical}"
  resource_group_name = local.rg_general
  scopes              = [azurerm_redis_cache.redis_cache[0].id]
  description         = var.descrip_errors
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_maximum
    metric_name      = var.metric_name_errors
    metric_namespace = "Microsoft.Cache/redis"
    operator         = var.operator_greater_than
    threshold        = var.threshold_errors
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.general[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
}

resource "azurerm_monitor_metric_alert" "memory_critical" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.memory_critical}-${local.alert_name_critical}"
  resource_group_name = local.rg_general
  scopes              = [azurerm_redis_cache.redis_cache[0].id]
  description         = var.descrip_memory_critical
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_maximum
    metric_name      = var.metric_name_memory_used
    metric_namespace = "Microsoft.Cache/redis"
    operator         = var.operator_greater_than
    threshold        = var.threshold_memory_used_critical
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.general[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
}

resource "azurerm_monitor_metric_alert" "memory_warning" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.memory_critical}-${local.alert_name_warning}"
  resource_group_name = local.rg_general
  scopes              = [azurerm_redis_cache.redis_cache[0].id]
  description         = var.descrip_memory_critical
  severity            = local.severity_2
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_maximum
    metric_name      = var.metric_name_memory_used
    metric_namespace = "Microsoft.Cache/redis"
    operator         = var.operator_greater_than
    threshold        = var.threshold_memory_used_warning
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.general[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
}

resource "azurerm_monitor_metric_alert" "cpu_used_critical" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.cpu_critical}-${local.alert_name_critical}"
  resource_group_name = local.rg_general
  scopes              = [azurerm_redis_cache.redis_cache[0].id]
  description         = var.descrip_cpu_critical
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_maximum
    metric_name      = var.metric_name_cpu_used
    metric_namespace = "Microsoft.Cache/redis"
    operator         = var.operator_greater_than
    threshold        = var.threshold_cpu_used_critical
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.general[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
}

resource "azurerm_monitor_metric_alert" "cpu_used_warning" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.cpu_critical}-${local.alert_name_warning}"
  resource_group_name = local.rg_general
  scopes              = [azurerm_redis_cache.redis_cache[0].id]
  description         = var.descrip_cpu_critical
  severity            = local.severity_2
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_maximum
    metric_name      = var.metric_name_cpu_used
    metric_namespace = "Microsoft.Cache/redis"
    operator         = var.operator_greater_than
    threshold        = var.threshold_cpu_used_warning
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.general[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
}

##############################
##   PostgreSQL for Gitlab  ##
##############################

module "postgres_gitlab" {
  count                               = var.gitlab_manage ? 1 : 0
  source                              = "../../modules/postgres"
  rg_name                             = local.rg_general
  location                            = var.location
  pg_name                             = var.gitlab_pg_name
  pg_db_names                         = var.gitlab_pg_db_names
  pg_admin_password                   = var.gitlab_pg_admin_password
  pg_ssl_enforcement_enabled          = var.gitlab_pg_ssl_enforcement_enabled
  pg_ssl_minimal_tls_version_enforced = var.gitlab_pg_ssl_minimal_tls_version_enforced
  # tags                                = var.tags
  #variables for Azure monitor
  env_name      = var.env_name
  env_prefix    = var.env_prefix
  alerts_manage = var.alerts_manage
}
