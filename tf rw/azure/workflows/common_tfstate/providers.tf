provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}
provider "azurerm" {
  features {}
  alias           = "ede_svcs"
  subscription_id = var.azure_subscription_id_internal
}
provider "azurerm" {
  features {}
  alias           = "hub_dns"
  subscription_id = var.azure_subscription_id_hub_dns
  client_id       = var.azuredns_client_id
  client_secret   = var.azuredns_client_secret
  tenant_id       = var.az_tenant_id
}