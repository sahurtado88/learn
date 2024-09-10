module "log_analytics_rg" {
  source   = "../../modules/resource_group"
  rg_name  = var.log_analytics_rg_name
  location = var.location
  tags     = var.tags
}

module "log_analytics" {
  source             = "../../modules/log_analytics"
  location           = var.location
  rg_name            = module.log_analytics_rg.name
  log_analytics_name = var.log_analytics_name
}
