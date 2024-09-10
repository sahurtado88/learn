module "aml_sa" {
  count            = var.configure_ml_workspace ? 1 : 0
  source           = "../../modules/storage_account"
  storage_name     = "${var.env_prefix}mlsa"
  rg_name          = module.rg.name
  location         = var.location
  env_name         = var.env_name
  env_prefix       = var.env_prefix
  replication_type = var.storage_replication_type
}
