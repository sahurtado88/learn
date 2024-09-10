provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "azurerm" {
  features {}
  alias           = "tenant_sub"
  subscription_id = var.subscription_id_tenant
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

provider "kubernetes" {
  host                   = var.aks_host
  client_certificate     = base64decode(var.client_certificate)
  client_key             = base64decode(var.client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

