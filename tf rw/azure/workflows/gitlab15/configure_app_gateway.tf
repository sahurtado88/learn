data "azurerm_web_application_firewall_policy" "waf_policy" {
  name                = local.waf_policy_name
  resource_group_name = local.rg_waf_policy
}

data "azurerm_log_analytics_workspace" "insights_appgwty" {
  count               = var.log_analytics_manage ? 1 : 0
  name                = local.log_analytics_name
  resource_group_name = local.rg_global
}
resource "azurerm_resource_group" "gitlab_app_gtwy_rg" {
  name     = local.app_gateway_rg_name
  location = var.location
}
module "app-gtwy" {
  source                                       = "../../modules/app_gateway"
  app_gateway_backend_http_setting_cba         = var.app_gateway_backend_http_setting_cba
  app_gateway_backend_http_setting_path        = var.app_gateway_backend_http_setting_path
  app_gateway_backend_http_setting_req_timeout = var.app_gateway_backend_http_setting_req_timeout
  app_gateway_frontend_name                    = local.app_gateway_frontend_name
  # app_gateway_frontend_port_name               = var.app_gateway_frontend_port_name
  app_gateway_frontend_port_number           = var.app_gateway_frontend_port_number
  app_gateway_frontend_subnet_address_prefix = "10.245.${150 + var.gitlab_network_block}.0/25"
  app_gateway_ip_configuration               = var.app_gateway_ip_configuration
  app_gateway_name                           = local.app_gateway_name
  app_gateway_public_ip_allocation_method    = var.app_gateway_public_ip_allocation_method
  # app_gateway_public_ip_name                   = local.app_gateway_public_ip_name
  app_gateway_rg_name                         = local.app_gateway_rg_name
  app_gateway_sku_capacity                    = var.app_gateway_sku_capacity
  app_gateway_sku_name                        = var.app_gateway_sku_name
  app_gateway_sku_tier                        = var.app_gateway_sku_tier
  app_gateway_backend_req_routing_rule_type   = var.app_gateway_backend_req_routing_rule_type
  app_gateway_public_ip_sku                   = var.app_gateway_public_ip_sku
  app_gateway_default_listener_name           = "gitlab"
  app_gateway_listener_hostnames              = var.app_gateway_listener_hostnames
  app_gateway_default_rule_priority           = var.app_gateway_default_rule_priority
  app_gateway_rewrite_response_add_headers    = var.app_gateway_rewrite_response_add_headers
  app_gateway_rewrite_response_remove_headers = var.app_gateway_rewrite_response_remove_headers
  # tags                                         = var.tags
  network_rg_name       = local.rg_network
  app_gateway_vnet_name = local.aks_vnet_name
  location              = var.location
  # app_gateway_listener_hostnames_https   = var.app_gateway_listener_hostnames_https
  app_gateway_log_analytics_workspace_id = var.log_analytics_manage ? data.azurerm_log_analytics_workspace.insights_appgwty[0].id : null
  # certificate_name                             = var.certificate_name #"ftds-sandbox-cert"
  certificate_name   = "${replace(var.dns_name_prefix, ".", "-")}-cert"
  key_vault_id       = data.azurerm_key_vault.akv.id
  firewall_policy_id = data.azurerm_web_application_firewall_policy.waf_policy.id
  depends_on = [
    azurerm_key_vault_certificate.domaincert, azurerm_resource_group.gitlab_app_gtwy_rg
  ]
  #variables for Azure monitor
  env_name      = "${var.env_name}-${var.gitlab_instance}"
  env_prefix    = var.env_prefix
  alerts_manage = var.alerts_manage
}

resource "azurerm_key_vault_access_policy" "akv" {
  key_vault_id            = data.azurerm_key_vault.akv.id
  tenant_id               = data.azurerm_key_vault.akv.tenant_id
  object_id               = module.app-gtwy.appgtwy_managed_object_id
  certificate_permissions = ["Get", "List"]
  secret_permissions      = ["Get"]
}
