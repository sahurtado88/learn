### ftds-private.rockwellautomation.com
module "private_dns" {
  source        = "../../modules/private_dns_zone"
  dns_zone_name = var.private_dns_name
  rg_name       = module.private_dns_rg.name
}

### private dns zone link###
resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link_function" {
  name                  = "link-dns-${var.env_prefix}-vnet-245"
  resource_group_name   = module.private_dns_rg.name
  virtual_network_id    = azurerm_virtual_network.global_vnet.id
  private_dns_zone_name = var.private_dns_name
  registration_enabled  = false
  depends_on = [
    module.private_dns
  ]
}

data "azurerm_private_dns_zone" "sa_blob_internal_private_dns" {
  count               = var.pep_manage ? 1 : 0
  provider            = azurerm.hub_dns
  name                = var.sa_blob_private_dns_name
  resource_group_name = var.hub_dns_rg_name
}

data "azurerm_private_dns_zone" "functions_internal_private_dns" {
  count               = var.pep_manage ? 1 : 0
  provider            = azurerm.hub_dns
  name                = var.azurewebsites_private_dns_name
  resource_group_name = var.hub_dns_rg_name
}
data "azurerm_private_dns_zone" "cosmosdb_internal_private_dns" {
  count               = var.pep_manage ? 1 : 0
  provider            = azurerm.hub_dns
  name                = var.mongo_cosmos_private_dns_name
  resource_group_name = var.hub_dns_rg_name
}
# data "azurerm_private_dns_zone" "azure_api_internal_private_dns" {
#   count               = var.pep_manage ? 1 : 0
#   provider            = azurerm.hub_dns
#   name                = var.azure_api_private_dns_name
#   resource_group_name = var.hub_dns_rg_name
# }

module "acr_priv_dns_zone" {
  source        = "../../modules/private_dns_zone"
  dns_zone_name = var.acr_private_dns_name
  rg_name       = module.private_dns_rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr_vnet_link" {
  name                  = module.acr_priv_dns_zone.name
  resource_group_name   = module.private_dns_rg.name
  private_dns_zone_name = module.acr_priv_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.global_vnet.id
  registration_enabled  = false
}

module "kv_priv_dns_zone" {
  source        = "../../modules/private_dns_zone"
  dns_zone_name = var.kv_private_dns_name
  rg_name       = module.private_dns_rg.name
}
resource "azurerm_private_dns_zone_virtual_network_link" "kv_vnet_link" {
  name                  = module.kv_priv_dns_zone.name
  resource_group_name   = module.private_dns_rg.name
  private_dns_zone_name = module.kv_priv_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.global_vnet.id
  registration_enabled  = false
}

module "sa_queue_priv_dns_zone" {
  source        = "../../modules/private_dns_zone"
  dns_zone_name = var.sa_queue_private_dns_name
  rg_name       = module.private_dns_rg.name
}
resource "azurerm_private_dns_zone_virtual_network_link" "sa_queue_vnet_link" {
  name                  = module.sa_queue_priv_dns_zone.name
  resource_group_name   = module.private_dns_rg.name
  private_dns_zone_name = module.sa_queue_priv_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.global_vnet.id
  registration_enabled  = false
}

module "sa_blob_priv_dns_zone" {
  source        = "../../modules/private_dns_zone"
  dns_zone_name = var.sa_blob_private_dns_name
  rg_name       = module.private_dns_rg.name
}
module "sa_file_priv_dns_zone" {
  source        = "../../modules/private_dns_zone"
  dns_zone_name = var.sa_file_private_dns_name
  rg_name       = module.private_dns_rg.name
}
resource "azurerm_private_dns_zone_virtual_network_link" "sa_blob_vnet_link" {
  name                  = module.sa_blob_priv_dns_zone.name
  resource_group_name   = module.private_dns_rg.name
  private_dns_zone_name = module.sa_blob_priv_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.global_vnet.id
  registration_enabled  = false
}
resource "azurerm_private_dns_zone_virtual_network_link" "sa_file_vnet_link" {
  name                  = module.sa_file_priv_dns_zone.name
  resource_group_name   = module.private_dns_rg.name
  private_dns_zone_name = module.sa_file_priv_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.global_vnet.id
  registration_enabled  = false
}

module "mongo_cosmos_priv_dns_zone" {
  source        = "../../modules/private_dns_zone"
  dns_zone_name = var.mongo_cosmos_private_dns_name
  rg_name       = module.private_dns_rg.name
}
resource "azurerm_private_dns_zone_virtual_network_link" "mongo_cosmos_vnet_link" {
  name                  = module.mongo_cosmos_priv_dns_zone.name
  resource_group_name   = module.private_dns_rg.name
  private_dns_zone_name = module.mongo_cosmos_priv_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.global_vnet.id
  registration_enabled  = false
}

# module "azure_api_priv_dns_zone" {
#   source        = "../../modules/private_dns_zone"
#   dns_zone_name = var.azure_api_private_dns_name
#   rg_name       = module.private_dns_rg.name
# }
# resource "azurerm_private_dns_zone_virtual_network_link" "azure_api_vnet_link" {
#   name                  = module.azure_api_priv_dns_zone.name
#   resource_group_name   = module.private_dns_rg.name
#   private_dns_zone_name = module.azure_api_priv_dns_zone.name
#   virtual_network_id    = azurerm_virtual_network.global_vnet.id
#   registration_enabled  = false
# }

module "azurewebsites_priv_dns_zone" {
  source        = "../../modules/private_dns_zone"
  dns_zone_name = var.azurewebsites_private_dns_name
  rg_name       = module.private_dns_rg.name
}
resource "azurerm_private_dns_zone_virtual_network_link" "azurewebsites_vnet_link" {
  name                  = module.azurewebsites_priv_dns_zone.name
  resource_group_name   = module.private_dns_rg.name
  private_dns_zone_name = module.azurewebsites_priv_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.global_vnet.id
  registration_enabled  = false
}
