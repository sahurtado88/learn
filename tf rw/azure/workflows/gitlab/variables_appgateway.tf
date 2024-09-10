# control variables
# variable "manage_app_gateway" {
#   default = false
# }

# variable "certificate_name" {
#   default = "ftds-sandbox-cert"
# }

variable "app_gateway_public_ip_allocation_method" {
  default = "Static"
}

variable "app_gateway_sku_name" {
  default = "WAF_v2"
}
variable "app_gateway_sku_tier" {
  default = "WAF_v2"
}
variable "app_gateway_sku_capacity" {
  default = 2
}
variable "app_gateway_ip_configuration" {
  default = "default-ipconfig"
}
# variable "app_gateway_frontend_port_name" {
#   default = "fe_port_name"
# }
variable "app_gateway_frontend_port_number" {
  default = 80
}
variable "app_gateway_backend_http_setting_cba" {
  default = "Disabled"
}
variable "app_gateway_backend_http_setting_path" {
  default = "/"
}
variable "app_gateway_backend_http_setting_req_timeout" {
  default = 60
}
variable "app_gateway_backend_req_routing_rule_type" {
  default = "Basic"
}
variable "app_gateway_public_ip_sku" {
  default = "Standard"
}
variable "app_gateway_listener_hostnames" {
  default = "sampleurl.rockwellautomation.com"
}
# variable "app_gateway_listener_hostnames_https" {
#   default = "sampleurl.rockwellautomation.com"
# }
variable "app_gateway_default_rule_priority" {
  type    = number
  default = 10
}
variable "app_gateway_rewrite_response_add_headers" {
  type = map(string)
  default = {
    "strict-transport-security" = "max-age=31536000; includeSubDomains"
    "referrer-policy"           = "no-referrer"
    "x-content-type-options"    = "nosniff"
    "x-content-security-policy" = "default-src 'self'; script-src 'self'; frame-ancestors 'none';"
  }
}

variable "app_gateway_rewrite_response_remove_headers" {
  type = list(string)
  default = [
    "server",
    "x-powered-by",
    "x-envoy-upstream-service-time"
  ]
}
