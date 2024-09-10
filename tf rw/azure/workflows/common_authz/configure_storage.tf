module "auth_storage_blob" {
  source         = "../../modules/storage_container"
  container_name = var.container_auth
  storage_name   = var.monitoring_storage_account_name
}