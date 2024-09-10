variable "app_gateway_rg_name" {}
variable "app_gateway_vnet_name" {}
variable "app_gateway_name" {}
variable "location" {}
variable "network_rg_name" {}
variable "app_gateway_frontend_subnet_address_prefix" {}
variable "app_gateway_frontend_name" {}
variable "app_gateway_public_ip_allocation_method" {}
variable "app_gateway_sku_name" {}
variable "app_gateway_sku_tier" {}
variable "app_gateway_sku_capacity" {}
variable "app_gateway_ip_configuration" {}
variable "app_gateway_frontend_port_number" {}
variable "app_gateway_backend_http_setting_cba" {}
variable "app_gateway_backend_http_setting_path" {}
variable "app_gateway_backend_http_setting_req_timeout" {}
variable "app_gateway_backend_req_routing_rule_type" {}
variable "app_gateway_public_ip_sku" {}
variable "app_gateway_default_listener_name" {}
variable "app_gateway_listener_hostnames" {}
variable "certificate_name" {}
variable "key_vault_id" {}
variable "firewall_policy_id" {}
variable "app_gateway_default_rule_priority" {
  type    = number
  default = 10
}
variable "app_gateway_rewrite_response_add_headers" {
  type    = map(string)
  default = {}
}
variable "app_gateway_rewrite_response_remove_headers" {
  type    = list(string)
  default = []
}
variable "app_gateway_log_analytics_workspace_id" {}
variable "app_gateway_diagnostic_setting_categories" {
  type = list(string)
  default = [
    "ApplicationGatewayAccessLog",
    "ApplicationGatewayPerformanceLog",
    "ApplicationGatewayFirewallLog"
  ]
}

variable "app_gateway_ssl_policy_name" {
  type    = string
  default = "AppGwSslPolicy20220101S"
}

variable "app_gateway_ssl_policy_type" {
  type    = string
  default = "Predefined"
}

variable "app_gateway_ssl_policy_min_protocol_ver" {
  type    = string
  default = "TLSv1_2"
}

variable "alerts_manage" {
  type    = bool
  default = false
}

variable "env_name" {
  type = string
}

variable "env_prefix" {
  type = string
}

variable "backend_last_byte" {
  type    = string
  default = "Alert-Backend Last Byte Response Metric-ApplicationGateway"
}

variable "backend_status_5xx" {
  type    = string
  default = "Alert-Backend Response Status As 5xx-ApplicationGateway"
}

variable "unhealthy_host" {
  type    = string
  default = "Alert-Unhealthy Host Count-ApplicationGateway"
}

variable "descrip_backend_last_byte" {
  type    = string
  default = "Time interval between start of establishing a connection to backend server and receiving the last byte of the response body."
}

variable "descrip_unhealthy_host" {
  type    = string
  default = "Number of unhealthy backend hosts."
}

variable "frequency" {
  type    = string
  default = "PT5M"
}

variable "window_size" {
  type    = string
  default = "PT15M"
}

variable "time_window" {
  type    = number
  default = 15
}

variable "frequency_5xx" {
  type    = number
  default = 5
}

variable "aggregation_average" {
  type    = string
  default = "Average"
}

variable "metric_name_backend_last_byte" {
  type    = string
  default = "BackendLastByteResponseTime"
}


variable "metric_name_unhealthy_host" {
  type    = string
  default = "UnhealthyHostCount"
}

variable "operator" {
  type    = string
  default = "GreaterThan"
}

variable "threshold_120000" {
  type    = number
  default = 120000
}

variable "threshold_4" {
  type    = number
  default = 4
}

variable "threshold_5" {
  type    = number
  default = 5
}
