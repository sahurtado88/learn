# module "apim_pep" {
#   count                = var.pep_manage ? 1 : 0
#   source               = "../../modules/private_endpoints"
#   location             = var.location
#   rg_name              = local.rg_general
#   subnet_endpoint_name = local.pep_subnet_name
#   pep_name             = local.api_management_name_pep
#   pep_manual_conn      = var.api_management_pep_manual_conn
#   private_conn_name    = data.azurerm_api_management.apim.name
#   private_conn_id      = data.azurerm_api_management.apim.id
#   network_rg_name      = local.rg_network
#   pep_vnet_name        = azurerm_virtual_network.global_vnet.name
#   subresource_names    = var.api_management_subresource_names
#   # private_zone_id      = data.azurerm_private_dns_zone.sa_blob_private_dns[count.index].id
#   private_zone_id = module.azure_api_priv_dns_zone.id
#   depends_on = [
#     # azurerm_virtual_network.global_vnet,
#     azurerm_subnet.pep,
#   ]
# }

# module "apim_pep_internal" {
#   count = var.pep_manage ? 1 : 0
#   providers = {
#     azurerm = azurerm.ede_svcs
#   }
#   source               = "../../modules/private_endpoints"
#   location             = var.internal_location
#   rg_name              = var.internal_pep_rg_name
#   subnet_endpoint_name = var.internal_pep_subnet_name
#   pep_name             = join("-", [local.api_management_name_pep, var.internal_name])
#   pep_manual_conn      = var.api_management_pep_manual_conn
#   private_conn_name    = data.azurerm_api_management.apim.name
#   private_conn_id      = data.azurerm_api_management.apim.id
#   network_rg_name      = var.internal_network_rg_name
#   pep_vnet_name        = var.internal_pep_vnet_name
#   subresource_names    = var.api_management_subresource_names
#   private_zone_id      = data.azurerm_private_dns_zone.azure_api_internal_private_dns[count.index].id
#   # depends_on = [
#   #   # module.redis_pep_internal # Because parallel PEP creation fails
#   # ]
# }