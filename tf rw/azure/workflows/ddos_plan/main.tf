module "ddos_protection_rg" {
  source   = "../../modules/resource_group"
  rg_name  = var.ddos_protection_rg_name
  location = var.location
  tags     = var.tags
}

module "ddos_protection" {
  source   = "../../modules/ddos_protection"
  name     = var.ddos_protection_name
  location = var.location
  rg_name  = module.ddos_protection_rg.name
}
