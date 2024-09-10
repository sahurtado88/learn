### {env_prefix}-rg-apim

module "apim_rg" {
  source   = "../../modules/resource_group"
  rg_name  = local.rg_apim
  location = var.location
  tags     = var.tags
}
