### log analytics workspace
module "log_analytics" {
  count              = var.log_analytics_manage ? 1 : 0
  source             = "../../modules/log_analytics"
  location           = var.location
  rg_name            = module.general_rg.name
  log_analytics_name = local.log_analytics_name
}


