module "ws_storage_blob" {
  providers = {
    azurerm = azurerm.tenant_sub
  }
  source         = "../../modules/storage_container"
  container_name = var.user
  storage_name   = format("%.24s", replace(var.tenant, "-", ""))
}