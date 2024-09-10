resource "azurerm_private_dns_zone" "pep_dns_zone" {
  name                = var.dns_zone_name
  resource_group_name = var.rg_name
  lifecycle {
    ignore_changes = [tags]
  }
}
