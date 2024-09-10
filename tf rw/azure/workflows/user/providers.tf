provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "azurerm" {
  features {}
  alias           = "tenant_sub"
  subscription_id = var.subscription_id_tenant
}