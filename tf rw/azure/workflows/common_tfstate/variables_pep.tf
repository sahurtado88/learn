# variable "tfstate" {
#   default = "tfstate"
# }
# variable "tfstate_pep_manual_conn" {
#   default = false
# }
# variable "tfstate_subresource_names" {
#   default = ["blob"]
# }
# variable "tfstate_dns_zone_name" {
#   default = "privatelink.blob.core.windows.net"
# }
# variable "subscription_id" {
#   description = "Variable to specifying different subscription for azurerm provider, e.g. using existing key vault"
# }
variable "azure_subscription_id_internal" {}
variable "azure_subscription_id_hub_dns" {}
# variable "internal_pep_subnet_name" {
#   default = "Subnet-01"
# }
# variable "internal_network_rg_name" {}
# variable "internal_pep_vnet_name" {}
# variable "internal_location" {}
# variable "internal_pep_rg_name" {}

# variable "hub_dns_rg_name" {}

# variable "tenant_vnet_address" {
#   default = ["10.245.0.0/16"]
# }
# variable "tenant_subnet_service_name" {
#   default = "service-tenant"
# }
# variable "tenant_subnet_service_address_prefixes" {
#   default = ["10.245.0.0/24"]
# }
# variable "tenant_enforce_service_network_policies" {
#   default = false
# }
# variable "tenant_subnet_endpoint_name" {
#   default = "endpoint-tenant"
# }
# variable "tenant_subnet_endpoint_address_prefixes" {
#   default = ["10.245.1.0/24"]
# }
# variable "tenant_enforce_endpoint_network_policies" {
#   default = false
# }
# variable "tenant_pep_name" {
#   default = "tenant-private-endpoint"
# }
# variable "tenant_pep_privserv_conn_name" {
#   default = "tenant-privateconnection"
# }



# variable "tenant_private_conn_name" {
#   default = "a"
# }
# variable "tenant_private_conn_id" {
#   default = "1"
# }

# variable "tenant_pep_vnet_name" {
#   default = "harness-tenant-vnet"
# }
# variable "tenant_manage_pep" {
#   default = false
# }
# variable "tenant_make_vnet" {
#   default = false
# }
# variable "tenant_pep_vnet_link_name" {
#   default = "harness-tenant-vnet-link"
# }

# variable "resource_group_private_dns_name" {}
# variable "boot_pep_vnet_name" {
#   default = "harness-bootstrap-vnet"
# }
# variable "bootstrap_svc_rg_name" {}
# variable "boot_subnet_service_name" {
#   default = "service-bootstrap"
# }
# variable "boot_subnet_endpoint_name" {
#   default = "endpoint-bootstrap"
# }
# variable "pep_manage" {
#   default = true
# }

# variable "cmn_subnet_endpoint_name" {}
