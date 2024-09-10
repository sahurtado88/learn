module "cosmosdb_account" {
  count                                = var.manage_cosmosdb ? 1 : 0
  source                               = "../../modules/cosmosdb_account"
  cosmosdb_account_name                = local.cosmosdb_account_name
  cosmosdb_account_resource_group_name = module.global_rg.name
  cosmosdb_account_location            = var.location
  #variables for Azure monitor
  env_name      = var.env_name
  env_prefix    = var.env_prefix
  alerts_manage = var.alerts_manage
}

module "cosmosdb_database" {
  count                                = var.manage_cosmosdb ? 1 : 0
  source                               = "../../modules/cosmosdb_database"
  cosmosdb_account_name                = local.cosmosdb_account_name
  cosmosdb_account_resource_group_name = module.global_rg.name
  cosmosdb_database_name               = local.cosmosdb_database_name
  depends_on                           = [module.cosmosdb_account]
}

module "cosmosdb_database_catalog" {
  count                                = var.manage_cosmosdb ? 1 : 0
  source                               = "../../modules/cosmosdb_database"
  cosmosdb_account_name                = local.cosmosdb_account_name
  cosmosdb_account_resource_group_name = module.global_rg.name
  cosmosdb_database_name               = local.cosmosdb_database_name_catalog
  depends_on                           = [module.cosmosdb_account]
}
