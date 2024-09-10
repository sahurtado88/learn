data "azurerm_key_vault" "kv" {
  count               = var.ai_manage ? 1 : 0
  name                = "${var.env_prefix}-${var.env_name}-keyvault"
  resource_group_name = "${var.env_prefix}-${var.env_name}-rg-keyvault"
}

data "azurerm_cognitive_account" "ai" {
  count               = var.ai_manage ? 1 : 0
  name                = "${var.env_prefix}-ai-${var.openai_location}"
  resource_group_name = "${var.env_prefix}-rg-ai"
}

data "azurerm_search_service" "search" {
  count               = var.ai_manage ? 1 : 0
  name                = "${var.env_prefix}-search"
  resource_group_name = "${var.env_prefix}-rg-ai"
}

resource "azurerm_key_vault_secret" "azure_openai_endpoint" {
  count        = var.ai_manage ? 1 : 0
  name         = var.azure_openai_endpoint_secret_name
  value        = data.azurerm_cognitive_account.ai[0].endpoint
  key_vault_id = data.azurerm_key_vault.kv[0].id
}

resource "azurerm_key_vault_secret" "azure_openai_key" {
  name         = var.azure_openai_key_secret_name
  value        = data.azurerm_cognitive_account.ai[0].primary_access_key
  key_vault_id = data.azurerm_key_vault.kv[0].id
}

resource "azurerm_key_vault_secret" "serch_service_endpoint" {
  count        = var.ai_manage ? 1 : 0
  name         = var.search_service_endpoint_secret_name
  value        = "https://${data.azurerm_search_service.search[0].name}.search.windows.net"
  key_vault_id = data.azurerm_key_vault.kv[0].id
}

resource "azurerm_key_vault_secret" "search_service_key" {
  count        = var.ai_manage ? 1 : 0
  name         = var.search_service_key_secret_name
  value        = data.azurerm_search_service.search[0].primary_key
  key_vault_id = data.azurerm_key_vault.kv[0].id
}
