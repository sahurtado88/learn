data "azurerm_client_config" "current" {}

module "aml_kv" {
  count                         = var.configure_ml_workspace ? 1 : 0
  env_prefix                    = var.env_prefix
  env_name                      = var.env_name
  source                        = "../../modules/keyvault"
  location                      = var.location
  name                          = "${var.env_prefix}-keyvault-ai-ml"
  resource_group_name           = module.rg.name
  sku_name                      = var.keyvault_sku_name
  soft_delete_retention_days    = var.keyvault_soft_delete_retention_days
  purge_protection_enabled      = var.keyvault_purge_protection_enabled
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  object_id                     = data.azurerm_client_config.current.object_id
  public_network_access_enabled = var.key_vault_public_network_access_enabled
  key_vault_manage_network_acls = var.key_vault_manage_network_acls
}


resource "azurerm_key_vault_secret" "openai_api_key" {
  count        = var.configure_ml_workspace ? 1 : 0
  name         = var.openai_api_key_secret_name
  value        = azurerm_cognitive_account.ai.primary_access_key
  key_vault_id = module.aml_kv[count.index].id
  depends_on   = [module.aml_kv]
}

resource "azurerm_key_vault_secret" "openai_api_endpoint" {
  count        = var.configure_ml_workspace ? 1 : 0
  name         = var.openai_endpoint_secret_name
  value        = azurerm_cognitive_account.ai.endpoint
  key_vault_id = module.aml_kv[count.index].id
  depends_on   = [module.aml_kv]
}

resource "azurerm_key_vault_secret" "azure_search_key" {
  count        = var.configure_ml_workspace ? 1 : 0
  name         = var.azure_search_key_secret_name
  value        = azurerm_search_service.embeddings.primary_key
  key_vault_id = module.aml_kv[count.index].id
  depends_on   = [module.aml_kv]
}

resource "azurerm_key_vault_secret" "azure_search_endpoint" {
  count        = var.configure_ml_workspace ? 1 : 0
  name         = var.azure_search_endpoint_secret_name
  value        = "https://${azurerm_search_service.embeddings.name}.search.windows.net"
  key_vault_id = module.aml_kv[count.index].id
  depends_on   = [module.aml_kv]
}

resource "azurerm_key_vault_secret" "retrieval_plugin_token" {
  count        = var.configure_ml_workspace ? 1 : 0
  name         = var.retrieval_plugin_token_secret_name
  value        = var.openai_bearer_token
  key_vault_id = module.aml_kv[count.index].id
  depends_on   = [module.aml_kv]
}
