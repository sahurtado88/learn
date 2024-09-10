### ftds-private.rockwellautomation.com
module "private_dns" {
  source        = "../../modules/private_dns_zone"
  dns_zone_name = var.private_dns_name
  rg_name       = module.private_dns_rg.name
}

### private dns zone link ###
resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  count                 = floor((var.env_max_clusters) / 4)
  name                  = format("link-dns-${var.env_prefix}-${var.env_name}-vnet-%03d", count.index)
  resource_group_name   = module.private_dns_rg.name
  virtual_network_id    = azurerm_virtual_network.aks_vnets[count.index].id
  private_dns_zone_name = var.private_dns_name
  registration_enabled  = false
  depends_on = [
    module.private_dns
  ]
}
resource "azurerm_private_dns_zone_virtual_network_link" "acr_dns_vnet_link" {
  count                 = floor((var.env_max_clusters) / 4)
  name                  = format("link-acr-${var.env_prefix}-${var.env_name}-vnet-%03d", count.index)
  resource_group_name   = local.rg_global_private_dns
  virtual_network_id    = azurerm_virtual_network.aks_vnets[count.index].id
  private_dns_zone_name = var.acr_private_dns_name
  registration_enabled  = false
}
resource "azurerm_private_dns_zone_virtual_network_link" "kv_dns_vnet_link" {
  count                 = floor((var.env_max_clusters) / 4)
  name                  = format("link-kv-${var.env_prefix}-${var.env_name}-vnet-%03d", count.index)
  resource_group_name   = local.rg_global_private_dns
  virtual_network_id    = azurerm_virtual_network.aks_vnets[count.index].id
  private_dns_zone_name = var.kv_private_dns_name
  registration_enabled  = false
}
resource "azurerm_private_dns_zone_virtual_network_link" "sa_blob_dns_vnet_link" {
  count                 = floor((var.env_max_clusters) / 4)
  name                  = format("link-blob-${var.env_prefix}-${var.env_name}-vnet-%03d", count.index)
  resource_group_name   = local.rg_global_private_dns
  virtual_network_id    = azurerm_virtual_network.aks_vnets[count.index].id
  private_dns_zone_name = var.sa_blob_private_dns_name
  registration_enabled  = false
}
resource "azurerm_private_dns_zone_virtual_network_link" "sa_file_dns_vnet_link" {
  count                 = ((var.env_max_clusters) / 4)
  name                  = format("link-file-${var.env_prefix}-${var.env_name}-vnet-%03d", count.index)
  resource_group_name   = local.rg_global_private_dns
  virtual_network_id    = azurerm_virtual_network.aks_vnets[count.index].id
  private_dns_zone_name = var.sa_file_private_dns_name
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "sa_queue_dns_vnet_link" {
  count                 = floor((var.env_max_clusters) / 4)
  name                  = format("link-queue-${var.env_prefix}-${var.env_name}-vnet-%03d", count.index)
  resource_group_name   = local.rg_global_private_dns
  virtual_network_id    = azurerm_virtual_network.aks_vnets[count.index].id
  private_dns_zone_name = var.sa_queue_private_dns_name
  registration_enabled  = false
}
resource "azurerm_private_dns_zone_virtual_network_link" "functions_dns_vnet_link" {
  name                  = "link-functions-${var.env_prefix}-${var.env_name}-vnet-000"
  resource_group_name   = local.rg_global_private_dns
  virtual_network_id    = azurerm_virtual_network.aks_vnets[0].id
  private_dns_zone_name = var.azurewebsites_private_dns_name
  registration_enabled  = false
}
resource "azurerm_private_dns_zone_virtual_network_link" "cosmosdb_dns_vnet_link" {
  count                 = floor((var.env_max_clusters) / 4)
  name                  = format("link-cosmosdb-${var.env_prefix}-${var.env_name}-vnet-%03d", count.index)
  resource_group_name   = local.rg_global_private_dns
  virtual_network_id    = azurerm_virtual_network.aks_vnets[count.index].id
  private_dns_zone_name = var.cosmosdb_private_dns_name
  registration_enabled  = false
}

