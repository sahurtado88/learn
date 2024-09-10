locals {
  search_service_pep_name    = "${var.env_prefix}-search-pep"
  cognitive_sevices_pep_name = "${var.env_prefix}-ai-${var.openai_location}-pep"
}
module "rg" {
  source   = "../../modules/resource_group"
  rg_name  = "${var.env_prefix}-rg-ai"
  location = var.location
  tags     = var.tags
}


data "azurerm_subnet" "pe" {
  count                = var.pep_manage ? 1 : 0
  resource_group_name  = "${var.env_prefix}-rg-global"
  virtual_network_name = "${var.env_prefix}-vnet-245"
  name                 = "${var.env_prefix}-global-pep-subnet"
}

data "azurerm_resource_group" "private_dns_rg" {
  count = var.pep_manage ? 1 : 0
  name  = "${var.env_prefix}-rg-private-dns"
}
