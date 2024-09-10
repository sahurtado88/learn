locals {
  cognitive_deployment_format = "OpenAI"
  default_policy_name         = "Microsoft.Default"
}
resource "azurerm_cognitive_account" "ai" {
  name                       = "${var.env_prefix}-ai-${var.openai_location}"
  location                   = var.openai_location
  resource_group_name        = module.rg.name
  kind                       = var.cognitive_services_kind
  sku_name                   = var.cognitive_services_sku_name
  dynamic_throttling_enabled = var.cognitive_dynamic_throttling_enabled
  custom_subdomain_name      = "${var.env_prefix}-ai-${var.openai_location}"
  # Identity
  identity {
    type = "SystemAssigned"
  }

  # Network configuration
  public_network_access_enabled = var.cognitive_public_access_enabled
  local_auth_enabled            = var.cognitive_local_auth_enabled
  tags                          = var.tags

}

resource "azurerm_cognitive_deployment" "openai" {
  name                 = var.openai_deployment_model_name
  cognitive_account_id = azurerm_cognitive_account.ai.id
  model {
    format  = local.cognitive_deployment_format
    name    = var.openai_deployment_model
    version = var.openai_deployment_model_version
  }

  rai_policy_name = "${var.env_prefix}-openai-raider-policy"

  scale {
    type     = var.openai_scale_type
    capacity = var.openai_tpm
  }
  version_upgrade_option = var.openai_version_upgrade_option
}

resource "azurerm_cognitive_deployment" "openai_global" {
  name                 = var.openai_global_deployment_model_name
  cognitive_account_id = azurerm_cognitive_account.ai.id
  model {
    format  = local.cognitive_deployment_format
    name    = var.openai_global_deployment_model
    version = var.openai_global_deployment_model_version
  }

  rai_policy_name = "${var.env_prefix}-openai-raider-policy"

  scale {
    type     = var.openai_global_scale_type
    capacity = var.openai_global_deployment_tpm
  }
  version_upgrade_option = var.openai_version_upgrade_option
}

resource "azurerm_cognitive_deployment" "openai_completion" {
  name                 = var.openai_completion_deployment_model_name
  cognitive_account_id = azurerm_cognitive_account.ai.id
  model {
    format  = local.cognitive_deployment_format
    name    = var.openai_completion_deployment_model
    version = var.openai_completion_deployment_model_version
  }

  rai_policy_name = "${var.env_prefix}-openai-raider-policy"
  scale {
    type     = var.openai_completion_scale_type
    capacity = var.openai_completion_tpm
  }
  version_upgrade_option = var.openai_version_upgrade_option
}

resource "azurerm_cognitive_deployment" "embeddings" {
  name                 = var.embeddings_deployment_model_name
  cognitive_account_id = azurerm_cognitive_account.ai.id
  model {
    format  = local.cognitive_deployment_format
    name    = var.embeddings_deployment_model
    version = var.embedding_deployment_model_version
  }
  rai_policy_name = local.default_policy_name
  scale {
    type     = var.embedding_scale_type
    capacity = var.embedding_tpm
  }
  version_upgrade_option = var.openai_version_upgrade_option
}
