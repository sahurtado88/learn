provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

provider "azurerm" {
  features {}
  alias           = "global_svcs"
  subscription_id = var.azure_subscription_id_global
}

provider "azurerm" {
  features {}
  alias           = "app_svcs"
  subscription_id = var.subscription_id
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

provider "azurerm" {
  features {}
  alias           = "ddos_plan"
  subscription_id = var.azure_subscription_id_ddos_plan != "null" ? var.azure_subscription_id_ddos_plan : var.subscription_id
}

provider "harness" {
  account_id = var.harness_provider_account_id
  api_key    = var.harness_provider_api_key
}