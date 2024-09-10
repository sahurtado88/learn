resource "azurerm_log_analytics_workspace" "insights" {
  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = var.rg_name
  retention_in_days   = 30
  lifecycle {
    ignore_changes = [tags]
  }
}
