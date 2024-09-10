module "search_service_pep" {
  count                = var.pep_manage ? 1 : 0
  source               = "../../modules/private_endpoints"
  location             = var.location
  rg_name              = module.rg.name
  subnet_endpoint_name = data.azurerm_subnet.pe[count.index].name
  pep_name             = local.search_service_pep_name
  pep_manual_conn      = var.search_service_pe_manual_connection
  private_conn_name    = azurerm_search_service.embeddings.name
  private_conn_id      = azurerm_search_service.embeddings.id
  network_rg_name      = data.azurerm_subnet.pe[count.index].resource_group_name
  pep_vnet_name        = data.azurerm_subnet.pe[count.index].virtual_network_name
  subresource_names    = var.search_service_subresource_names
  private_zone_id      = module.search_service_private_dns[count.index].id
  depends_on = [
    azurerm_search_service.embeddings,
    module.search_service_private_dns
  ]
}

module "search_service_pep_internal" {
  providers = {
    azurerm = azurerm.ede_svcs
  }
  count                = var.pep_manage ? 1 : 0
  source               = "../../modules/private_endpoints"
  location             = var.internal_location
  rg_name              = var.internal_pep_rg_name
  subnet_endpoint_name = var.internal_pep_subnet_name
  pep_name             = join("-", [local.search_service_pep_name, var.internal_name])
  pep_manual_conn      = var.search_service_pe_manual_connection
  private_conn_name    = azurerm_search_service.embeddings.name
  private_conn_id      = azurerm_search_service.embeddings.id
  network_rg_name      = var.internal_network_rg_name
  pep_vnet_name        = var.internal_pep_vnet_name
  subresource_names    = var.search_service_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.search_service_internal_private_dns[count.index].id
  depends_on = [
    azurerm_search_service.embeddings
  ]
}

module "cognitive_services_pep" {
  count                = var.pep_manage ? 1 : 0
  source               = "../../modules/private_endpoints"
  location             = var.location
  rg_name              = module.rg.name
  subnet_endpoint_name = data.azurerm_subnet.pe[count.index].name
  pep_name             = local.cognitive_sevices_pep_name
  pep_manual_conn      = var.search_service_pe_manual_connection
  private_conn_name    = azurerm_cognitive_account.ai.name
  private_conn_id      = azurerm_cognitive_account.ai.id
  network_rg_name      = data.azurerm_subnet.pe[count.index].resource_group_name
  pep_vnet_name        = data.azurerm_subnet.pe[count.index].virtual_network_name
  subresource_names    = var.cognitive_services_subresource_names
  private_zone_id      = module.cognitive_services_private_dns[count.index].id
  depends_on = [
    azurerm_cognitive_account.ai,
    module.cognitive_services_private_dns
  ]
}

module "cognitive_services_pep_internal" {
  providers = {
    azurerm = azurerm.ede_svcs
  }
  count                = var.pep_manage ? 1 : 0
  source               = "../../modules/private_endpoints"
  location             = var.internal_location
  rg_name              = var.internal_pep_rg_name
  subnet_endpoint_name = var.internal_pep_subnet_name
  pep_name             = join("-", [local.cognitive_sevices_pep_name, var.internal_name])
  pep_manual_conn      = var.cognitive_services_pe_manual_connection
  private_conn_name    = azurerm_cognitive_account.ai.name
  private_conn_id      = azurerm_cognitive_account.ai.id
  network_rg_name      = var.internal_network_rg_name
  pep_vnet_name        = var.internal_pep_vnet_name
  subresource_names    = var.cognitive_services_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.cognitive_services_internal_private_dns[count.index].id
  depends_on = [
    azurerm_cognitive_account.ai
  ]
}
