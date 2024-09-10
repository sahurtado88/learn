
#########################
##   Redis for Gitlab  ##
#########################

resource "azurerm_resource_group" "gitlab_rg" {
  name     = local.rg_general
  location = var.location
}
resource "azurerm_redis_cache" "redis_cache" {
  count                         = var.gitlab_manage ? 1 : 0
  name                          = var.common_redis_name
  location                      = var.location
  resource_group_name           = local.rg_general
  replicas_per_master           = var.common_redis_replicas_per_master
  capacity                      = var.common_redis_capacity
  family                        = var.common_redis_family
  sku_name                      = var.common_redis_sku
  enable_non_ssl_port           = var.common_redis_enable_non_ssl
  zones                         = var.common_redis_zones
  depends_on                    = [azurerm_resource_group.gitlab_rg]
  public_network_access_enabled = false
}

#Alerts created for RedisCache

locals {
  alert_name_critical = "${var.env_prefix}-${var.env_name}-${var.gitlab_instance}-Critical-Infra"
  alert_name_warning  = "${var.env_prefix}-${var.env_name}-${var.gitlab_instance}-Warning-Infra"
  severity_0          = "0"
  severity_2          = "2"
}

data "azurerm_monitor_action_group" "general" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.env_prefix}-${var.env_name}-${var.gitlab_instance}-agn-alerts-General"
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
resource "azurerm_subnet" "postgresflex" {
  count                = var.gitlab_manage ? 1 : 0
  name                 = "${var.env_prefix}-${var.env_name}-${var.gitlab_instance}-postgresflex"
  resource_group_name  = data.azurerm_virtual_network.common_vnet.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.common_vnet.name

  address_prefixes  = [var.postgres_flexible_subnet_address_prefixes]
  service_endpoints = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}
module "postgres_gitlab" {
  count             = var.gitlab_manage ? 1 : 0
  source            = "../../modules/postgresflex"
  rg_name           = local.rg_general
  location          = var.location
  pg_name           = var.gitlab_pg_name
  pg_db_names       = var.gitlab_pg_db_names
  pg_admin_password = var.gitlab_pg_admin_password
  # tags                                = var.tags
  #variables for Azure monitor
  env_name      = "${var.env_name}-${var.gitlab_instance}"
  env_prefix    = var.env_prefix
  alerts_manage = var.alerts_manage

  delegated_subnet_id = azurerm_subnet.postgresflex[0].id
  private_dns_zone_id = data.azurerm_private_dns_zone.postgresql_private_dns[count.index].id
}
