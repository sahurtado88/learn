module "cosmosdb_database_project" {
  count                                = var.manage_cosmosdb ? 1 : 0
  source                               = "../../modules/cosmosdb_database"
  cosmosdb_account_name                = local.cosmosdb_account_name
  cosmosdb_account_resource_group_name = local.rg_global
  cosmosdb_database_name               = var.cosmosdb_database_name_project
  cosmosdb_throughput                  = var.cosmosdb_throughput
}