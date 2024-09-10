locals {
  aks_rg_name = "${var.env_prefix}-${var.env_name}-rg-aks-cluster"
  aks_name    = "${var.env_prefix}-${var.env_name}-aks-cluster-000"
  secret_name = "oai-keys"
  namespace   = "ra-common"
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_rg_name
}

data "azurerm_cognitive_account" "ai" {
  name                = "${var.env_prefix}-ai-${var.openai_location}"
  resource_group_name = "${var.env_prefix}-rg-ai"
}

data "azurerm_search_service" "ai" {
  name                = "${var.env_prefix}-search"
  resource_group_name = "${var.env_prefix}-rg-ai"
}


resource "kubernetes_secret" "oai_keys" {
  metadata {
    name      = local.secret_name
    namespace = local.namespace
  }

  data = {
    BEARER_TOKEN         = var.openai_bearer_token
    AZURE_OPENAI_API_KEY = data.azurerm_cognitive_account.ai.primary_access_key
    AZURESEARCH_SERVICE  = data.azurerm_search_service.ai.name
    AZURESEARCH_API_KEY  = data.azurerm_search_service.ai.primary_key
    AZURE_ENDPOINT       = data.azurerm_cognitive_account.ai.endpoint
  }

  type = "kubernetes.io/generic"
}
