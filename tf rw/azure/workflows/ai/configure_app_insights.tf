data "azurerm_resource_group" "global" {
  name = "${var.env_prefix}-rg-global"
}
data "azurerm_log_analytics_workspace" "global" {
  name                = "${var.env_prefix}-log-analytics-workspace"
  resource_group_name = data.azurerm_resource_group.global.name
}
module "aml_app_insights" {
  count                      = var.configure_ml_workspace ? 1 : 0
  source                     = "../../modules/application_insights"
  application_insights_name  = "${var.env_prefix}-ai"
  application_type           = var.app_insights_application_type
  rg_name                    = module.rg.name
  location                   = var.location
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.global.id
}
