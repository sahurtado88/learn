provider "azurerm" {
  features {}
}


# This "global_svcs" azurerm provider is used of specifying subscription id
# of existing KeyVault, DNS Zone etc to use.
provider "azurerm" {
  features {}
  alias           = "global_svcs"
  subscription_id = var.azure_subscription_id_global
}
