# module "priv_dns_zone" {
#   source        = "../../modules/private_dns_zone"
#   dns_zone_name = var.tfstate_dns_zone_name
#   rg_name       = var.tfstate_rg_name
#   depends_on = [
#     module.resource_group
#   ]
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "acr_vnet_link" {
#   name                  = module.priv_dns_zone.name
#   resource_group_name   = var.tfstate_rg_name
#   private_dns_zone_name = module.priv_dns_zone.name
#   virtual_network_id    = azurerm_virtual_network.tfstate_vnet.id
#   registration_enabled  = false
# }
