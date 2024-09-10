resource "azurerm_api_management" "api_management" {
  name                = var.api_management_name
  location            = var.location
  resource_group_name = var.rg_name
  publisher_name      = var.api_management_publisher_name
  publisher_email     = var.api_management_publisher_email

  sku_name = var.api_management_sku_name

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
