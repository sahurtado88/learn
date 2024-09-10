

# module "private_endpoint" {
#   source               = "../../modules/private_endpoints"
#   location             = var.location
#   rg_name              = var.tfstate_rg_name
#   subnet_endpoint_name = azurerm_subnet.tfstate_subnet.name
#   pep_name             = join("-", [var.tfstate, "pep"])
#   pep_manual_conn      = var.tfstate_pep_manual_conn
#   private_conn_name    = module.storage_account.storage_name
#   private_conn_id      = module.storage_account.storage_id
#   network_rg_name      = var.tfstate_rg_name
#   pep_vnet_name        = var.tfstate_vnet_name
#   subresource_names    = var.tfstate_subresource_names
#   private_zone_id      = module.priv_dns_zone.id
#   depends_on = [
#     azurerm_virtual_network.tfstate_vnet
#   ]
# }

# module "tfstate_internal_endpoint" {
#   providers = {
#     azurerm = azurerm.ede_svcs
#   }

#   source               = "../../modules/private_endpoints"
#   location             = var.internal_location
#   rg_name              = var.internal_pep_rg_name
#   subnet_endpoint_name = var.internal_pep_subnet_name
#   pep_name             = join("-", [var.tfstate, "pep"])
#   pep_manual_conn      = var.tfstate_pep_manual_conn
#   private_conn_name    = module.storage_account.storage_name
#   private_conn_id      = module.storage_account.storage_id
#   network_rg_name      = var.internal_network_rg_name
#   pep_vnet_name        = var.internal_pep_vnet_name
#   subresource_names    = var.tfstate_subresource_names
#   private_zone_id      = data.azurerm_private_dns_zone.internal_private_dns.id
# }

# data "azurerm_private_dns_zone" "internal_private_dns" {
#   provider            = azurerm.hub_dns
#   name                = var.tfstate_dns_zone_name
#   resource_group_name = var.hub_dns_rg_name
# }
