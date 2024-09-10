resource "azurerm_user_assigned_identity" "managed_identity" {
  location            = var.location
  resource_group_name = var.rg_name
  name                = var.managed_identity_name
  lifecycle {
    ignore_changes = [tags]
  }
}
