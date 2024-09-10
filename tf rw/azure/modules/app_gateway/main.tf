resource "azurerm_subnet" "frontend" {
  name                 = var.app_gateway_frontend_name
  resource_group_name  = var.network_rg_name
  virtual_network_name = var.app_gateway_vnet_name
  address_prefixes     = [var.app_gateway_frontend_subnet_address_prefix]
  service_endpoints    = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
}
resource "azurerm_public_ip" "app_gateway_public_ip" {
  name                = "${var.app_gateway_name}-pip"
  resource_group_name = var.app_gateway_rg_name
  location            = var.location
  allocation_method   = var.app_gateway_public_ip_allocation_method
  sku                 = var.app_gateway_public_ip_sku
}

#&nbsp;since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${var.app_gateway_default_listener_name}-bep"
  frontend_port_name             = "${var.app_gateway_name}-feport"
  frontend_ip_configuration_name = "${var.app_gateway_name}-feip"
  http_setting_name              = "${var.app_gateway_default_listener_name}-hs"
  listener_name                  = var.app_gateway_default_listener_name
  request_routing_rule_name      = "${var.app_gateway_default_listener_name}-rule"
  response_rewrite_set_name      = "${var.app_gateway_name}-rewrite-response"
  frontend_port_name_https       = "${var.app_gateway_name}-httpsfeport"
  diagnostic_setting_name        = "${var.app_gateway_name}-diagnostic-setting"
}

resource "azurerm_application_gateway" "app_gateway" {
  name                = var.app_gateway_name
  resource_group_name = var.app_gateway_rg_name
  location            = var.location
  firewall_policy_id  = var.firewall_policy_id

  depends_on = [
    azurerm_user_assigned_identity.appgtwy
  ]

  sku {
    name     = var.app_gateway_sku_name     #"Standard_Small"
    tier     = var.app_gateway_sku_tier     #"Standard"
    capacity = var.app_gateway_sku_capacity #2
  }

  gateway_ip_configuration {
    name      = var.app_gateway_ip_configuration #"my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.frontend.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = var.app_gateway_frontend_port_number #80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.app_gateway_public_ip.id
  }

  frontend_port {
    name = local.frontend_port_name_https
    port = 443
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = var.app_gateway_backend_http_setting_cba  # "Disabled"
    path                  = var.app_gateway_backend_http_setting_path #"/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = var.app_gateway_backend_http_setting_req_timeout #60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
    host_names                     = [var.app_gateway_listener_hostnames]
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = var.app_gateway_backend_req_routing_rule_type #"Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority                   = var.app_gateway_default_rule_priority
  }

  rewrite_rule_set {
    name = local.response_rewrite_set_name

    rewrite_rule {
      name          = "${local.response_rewrite_set_name}-add-headers"
      rule_sequence = 100
      dynamic "response_header_configuration" {
        for_each = var.app_gateway_rewrite_response_add_headers
        content {
          header_name  = response_header_configuration.key
          header_value = response_header_configuration.value
        }
      }
    }

    rewrite_rule {
      name          = "${local.response_rewrite_set_name}-remove-headers"
      rule_sequence = 110
      dynamic "response_header_configuration" {
        for_each = var.app_gateway_rewrite_response_remove_headers
        content {
          header_name  = response_header_configuration.value
          header_value = ""
        }
      }
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.appgtwy.id]
  }


  ssl_certificate {
    name = var.certificate_name
    # key_vault_secret_id = data.azurerm_key_vault_certificate.ssl_cert.secret_id
    key_vault_secret_id = data.azurerm_key_vault_certificate.ssl_cert.versionless_secret_id
  }

  ssl_policy {
    policy_name          = var.app_gateway_ssl_policy_name
    policy_type          = var.app_gateway_ssl_policy_type
    min_protocol_version = var.app_gateway_ssl_policy_min_protocol_ver
  }

  lifecycle {
    ignore_changes = [tags, gateway_ip_configuration, frontend_port, frontend_ip_configuration, frontend_port, backend_address_pool, backend_http_settings, http_listener, request_routing_rule, probe, redirect_configuration]
  }

}

data "azurerm_key_vault_certificate" "ssl_cert" {
  name         = var.certificate_name #"ftds-sandbox-cert"
  key_vault_id = var.key_vault_id
}

resource "azurerm_user_assigned_identity" "appgtwy" {
  resource_group_name = var.app_gateway_rg_name
  location            = var.location
  name                = "${var.app_gateway_name}-uaid"
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_diagnostic_setting" "appgtwy" {
  name                       = local.diagnostic_setting_name
  target_resource_id         = azurerm_application_gateway.app_gateway.id
  log_analytics_workspace_id = var.app_gateway_log_analytics_workspace_id

  depends_on = [
    azurerm_application_gateway.app_gateway
  ]

  dynamic "enabled_log" {
    for_each = var.app_gateway_diagnostic_setting_categories
    content {
      category = enabled_log.value
    }
  }
}

#Alerts created for Postgres

locals {
  alert_name_critical = "${var.env_prefix}-${var.env_name}-Critical-Infra"
  severity_0          = "0"
  severity_1          = "1"
  severity_3          = "3"
}

data "azurerm_monitor_action_group" "appgw" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.env_prefix}-${var.env_name}-agn-alerts-AppGW"
  resource_group_name = "ftds-monitoring-alerts"
}

resource "azurerm_monitor_metric_alert" "backend_last_byte" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.backend_last_byte}-${var.app_gateway_name}-${local.alert_name_critical}"
  resource_group_name = var.app_gateway_rg_name
  scopes              = [azurerm_application_gateway.app_gateway.id]
  description         = var.descrip_backend_last_byte
  severity            = local.severity_3
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_average
    metric_name      = var.metric_name_backend_last_byte
    metric_namespace = "Microsoft.Network/applicationGateways"
    operator         = var.operator
    threshold        = var.threshold_120000
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.appgw[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}


resource "azurerm_monitor_metric_alert" "unhealthy_host" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.unhealthy_host}-${var.app_gateway_name}-${local.alert_name_critical}"
  resource_group_name = var.app_gateway_rg_name
  scopes              = [azurerm_application_gateway.app_gateway.id]
  description         = var.descrip_unhealthy_host
  severity            = local.severity_1
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation_average
    metric_name      = var.metric_name_unhealthy_host
    metric_namespace = "Microsoft.Network/applicationGateways"
    operator         = var.operator
    threshold        = var.threshold_4
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.appgw[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "backend_status_5xx" {
  count               = var.alerts_manage ? 1 : 0
  data_source_id      = azurerm_application_gateway.app_gateway.id
  time_window         = var.time_window
  frequency           = var.frequency_5xx
  severity            = local.severity_0
  location            = var.location
  name                = "${var.backend_status_5xx}-${var.app_gateway_name}-${local.alert_name_critical}"
  query               = <<-QUERY
  AzureDiagnostics
    | where ResourceType == "APPLICATIONGATEWAYS" and OperationName == "ApplicationGatewayAccess" and httpStatus_d > 499 and requestUri_s !endswith "/live"
  QUERY
  resource_group_name = var.app_gateway_rg_name
  action {
    action_group = [data.azurerm_monitor_action_group.appgw[0].id]
  }
  trigger {
    operator  = var.operator
    threshold = var.threshold_5
  }
  auto_mitigation_enabled = true
  lifecycle {
    ignore_changes = [tags]
  }
}
