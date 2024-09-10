# data "azurerm_api_management" "apim" {
#   name                = local.api_management_name
#   resource_group_name = local.rg_apim
# }
module "functions_storage_account" {
  source           = "../../modules/storage_account"
  rg_name          = local.rg_global
  storage_name     = local.storage_account_name
  replication_type = var.monitoring_storage_replication_type
  location         = var.location
  # tags             = var.tags
  storage_manage_network = var.storage_account_manage_selected_networks
  storage_network_access = var.storage_account_manage_pep ? "Deny" : "Allow"
  # storage_subnet_ids     = [data.azurerm_subnet.base-endpoint.id, data.azurerm_subnet.endpoint.id]
  depends_on = [
    module.global_rg
  ]
  #variables for Azure monitor
  env_name      = var.env_name
  env_prefix    = var.env_prefix
  alerts_manage = var.alerts_manage
}

module "azure_functions" {
  source                     = "../../modules/azure_functions"
  rg_name                    = local.rg_global
  storage_account_name       = local.storage_account_name
  storage_account_access_key = module.functions_storage_account.primary_access_key
  service_plan_name          = local.service_plan_name
  function_app_name          = local.function_app_name
  location                   = var.location

  application_insights_connection_string = module.application_insights.connection_string
  application_insights_key               = module.application_insights.instrumentation_key
  # api_management_api_id = data.azurerm_api_management.apim.id
  azurerm_subnet_id = azurerm_subnet.functions.id

  app_settings_database = local.cosmosdb_database_name
  connection_strings    = module.cosmosdb_account[0].cosmosdb_account_connection_strings
  # certificate_thumbprint = azurerm_key_vault_certificate.functionscert[0].thumbprint

  depends_on = [module.functions_storage_account, module.cosmosdb_account, azurerm_subnet.functions]
  #variables for Azure monitor
  env_name      = var.env_name
  env_prefix    = var.env_prefix
  alerts_manage = var.alerts_manage
}

# vnet integration
resource "azurerm_subnet" "functions" {
  name                 = local.functions_subnet_name
  resource_group_name  = module.global_rg.name
  virtual_network_name = azurerm_virtual_network.global_vnet.name
  address_prefixes     = [var.azurerm_subnet_address_prefixes]

  delegation {
    name = local.function_delegation_name
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}