data "azurerm_virtual_network" "pep_vnet" {
  name                = var.pep_vnet_name
  resource_group_name = var.network_rg_name
}
data "azurerm_subnet" "endpoint" {
  name                 = var.subnet_endpoint_name
  resource_group_name  = data.azurerm_virtual_network.pep_vnet.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.pep_vnet.name
}
resource "azurerm_private_endpoint" "pep" {
  name                = var.pep_name
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = data.azurerm_subnet.endpoint.id
  private_dns_zone_group {
    name                 = "Default"
    private_dns_zone_ids = [var.private_zone_id]
  }

  private_service_connection {
    name                           = var.private_conn_name
    private_connection_resource_id = var.private_conn_id
    is_manual_connection           = var.pep_manual_conn
    subresource_names              = var.subresource_names
  }
  lifecycle {
    ignore_changes = [tags, private_dns_zone_group, private_service_connection, subnet_id]
  }
}
