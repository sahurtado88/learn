#### ftds-{env}-rg-tenant
module "tenant_rg" {
  source   = "../../modules/resource_group"
  rg_name  = "${var.env_prefix}-${var.env_name}-rg-tenant"
  location = var.location
  tags     = var.tags
}
