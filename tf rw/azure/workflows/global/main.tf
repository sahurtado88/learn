locals {
  rg_global                      = "${var.env_prefix}-rg-global"
  cosmosdb_account_name          = "${var.env_prefix}-cosmosdb"
  cosmosdb_database_name         = "deployment"
  cosmosdb_database_name_catalog = "catalog"
  cosmosdb_pep_name              = "${var.env_prefix}-cosmosdb-pep"

  global_vnet_name          = "${var.env_prefix}-vnet-245"
  acr_pep_name              = "${var.env_prefix}-acr-pep"
  global_pep_subnet_name    = "${var.env_prefix}-global-pep-subnet"
  log_analytics_name        = "${var.env_prefix}-log-analytics-workspace"
  application_insights_name = "${var.env_prefix}-application-insights"
  keyvault_name             = "${var.env_prefix}-keyvault"
  keyvault_pep_name         = "${var.env_prefix}-keyvault-pep"
  fw_policy_name            = "${var.env_prefix}-waf-policy"
  fw_grafana_policy_name    = "${var.env_prefix}-grafana-waf-policy"

  storage_account_name     = "${var.env_prefix}rafuncsa"
  service_plan_name        = "${var.env_prefix}-deployment-functions-plan"
  function_app_name        = "${var.env_prefix}-deployment-functions"
  function_delegation_name = "${var.env_prefix}-functions-delegation"
  sa_functions_pep_name    = "${var.env_prefix}-sa-functions-pep"
  functions_pep_name       = "${var.env_prefix}-functions-pep"
  functions_subnet_name    = "${var.env_prefix}-functions-subnet"

  rg_general      = "${var.env_prefix}-rg-global"
  pep_subnet_name = "${var.env_prefix}-global-pep-subnet"
  rg_network      = "${var.env_prefix}-rg-global"
}
