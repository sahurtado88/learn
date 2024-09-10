###########        Log Analytics Workspace         ##
#######

module "log_analytics" {
  source   = "../../modules/log_analytics"
  location = var.location
  rg_name  = module.global_rg.name
  # tags               = var.tags
  log_analytics_name = local.log_analytics_name
}


