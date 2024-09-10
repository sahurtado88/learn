###########    Application Insights Workspace      ##
#######

module "application_insights" {
  source                     = "../../modules/application_insights"
  application_insights_name  = local.application_insights_name
  location                   = var.location
  rg_name                    = module.global_rg.name
  log_analytics_workspace_id = module.log_analytics.log_analytics_id
}
