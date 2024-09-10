locals {
  manage_pep = var.tenant_manage_pep || var.force_manage_pep
}

data "azurerm_private_dns_zone" "sa_priv_dns_zone" {
  name                = var.tenant_dns_zone_name
  resource_group_name = local.rg_private_dns
}
data "azurerm_private_dns_zone" "sa_file_priv_dns_zone" {
  name                = var.tenant_file_dns_zone_name
  resource_group_name = local.rg_private_dns
}

data "azurerm_subnet" "endpoint" {
  name                 = local.pep_service_endpoint
  resource_group_name  = local.rg_network
  virtual_network_name = format(local.aks_vnet_name, 0)
}

data "azurerm_private_dns_zone" "tenant_internal_private_dns" {
  provider            = azurerm.hub_dns
  name                = var.tenant_dns_zone_name
  resource_group_name = var.hub_dns_rg_name
}

data "azurerm_private_dns_zone" "tenant_file_internal_private_dns" {
  provider            = azurerm.hub_dns
  name                = var.tenant_file_dns_zone_name
  resource_group_name = var.hub_dns_rg_name
}


module "tenant_pep" {
  count                = local.manage_pep ? 1 : 0
  source               = "../../modules/private_endpoints"
  location             = var.location
  rg_name              = local.rg_tenant
  subnet_endpoint_name = data.azurerm_subnet.endpoint.name
  pep_name             = join("-", [var.tenant, "pep"])
  pep_manual_conn      = var.tenant_pep_manual_conn
  private_conn_name    = module.storageaccount.storage_name
  private_conn_id      = module.storageaccount.storage_id
  network_rg_name      = local.rg_network
  pep_vnet_name        = format(local.aks_vnet_name, 0)
  subresource_names    = var.tenant_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.sa_priv_dns_zone.id
}


module "tenant_pep_internal" {
  count = local.manage_pep ? 1 : 0
  providers = {
    azurerm = azurerm.ede_svcs
  }

  source               = "../../modules/private_endpoints"
  location             = var.internal_location
  rg_name              = var.internal_pep_rg_name
  subnet_endpoint_name = var.internal_pep_subnet_name
  pep_name             = join("-", [var.tenant, "pep-internal"])
  pep_manual_conn      = var.tenant_pep_manual_conn
  private_conn_name    = module.storageaccount.storage_name
  private_conn_id      = module.storageaccount.storage_id
  network_rg_name      = var.internal_network_rg_name
  pep_vnet_name        = var.internal_pep_vnet_name
  subresource_names    = var.tenant_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.tenant_internal_private_dns.id
}

module "tenant_file_pep" {
  count                = local.manage_pep ? 1 : 0
  source               = "../../modules/private_endpoints"
  location             = var.location
  rg_name              = local.rg_tenant
  subnet_endpoint_name = data.azurerm_subnet.endpoint.name
  pep_name             = join("-", [var.tenant, "file", "pep"])
  pep_manual_conn      = var.tenant_pep_manual_conn
  private_conn_name    = module.storageaccount.storage_name
  private_conn_id      = module.storageaccount.storage_id
  network_rg_name      = local.rg_network
  pep_vnet_name        = format(local.aks_vnet_name, 0)
  subresource_names    = var.tenant_file_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.sa_file_priv_dns_zone.id
}

module "tenant_file_pep_internal" {
  count = local.manage_pep ? 1 : 0
  providers = {
    azurerm = azurerm.ede_svcs
  }

  source               = "../../modules/private_endpoints"
  location             = var.internal_location
  rg_name              = var.internal_pep_rg_name
  subnet_endpoint_name = var.internal_pep_subnet_name
  pep_name             = join("-", [var.tenant, "file", "pep-internal"])
  pep_manual_conn      = var.tenant_pep_manual_conn
  private_conn_name    = module.storageaccount.storage_name
  private_conn_id      = module.storageaccount.storage_id
  network_rg_name      = var.internal_network_rg_name
  pep_vnet_name        = var.internal_pep_vnet_name
  subresource_names    = var.tenant_file_subresource_names
  private_zone_id      = data.azurerm_private_dns_zone.tenant_file_internal_private_dns.id
}
