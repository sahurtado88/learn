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

provider "azurerm" {
  features {}
  alias           = "ede_svcs"
  subscription_id = var.azure_subscription_id_internal
}
provider "harness" {
  account_id = var.harness_provider_account_id
  api_key    = var.harness_provider_api_key
}

# AKS Cluster is not being using for common svc right now.
# Enable when we start deploying AKS Cluster for common
provider "kubernetes" {
  host                   = module.aks.aks_host
  client_certificate     = base64decode(module.aks.aks_client_certificate)
  client_key             = base64decode(module.aks.aks_client_key)
  cluster_ca_certificate = base64decode(module.aks.aks_cluster_ca_certificate)
}
provider "azurerm" {
  features {}
  alias           = "hub_dns"
  subscription_id = var.azure_subscription_id_hub_dns
  client_id       = var.azuredns_client_id
  client_secret   = var.azuredns_client_secret
  tenant_id       = var.az_tenant_id
}