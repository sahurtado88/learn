resource "azurerm_search_service" "embeddings" {
  name                          = "${var.env_prefix}-search"
  location                      = var.location
  resource_group_name           = module.rg.name
  sku                           = var.search_service_sku
  partition_count               = var.search_service_partition_count
  replica_count                 = var.search_service_replica_count
  local_authentication_enabled  = var.search_service_local_authentication_enabled
  public_network_access_enabled = var.search_service_public_network_access_enabled
  tags                          = var.tags
}
