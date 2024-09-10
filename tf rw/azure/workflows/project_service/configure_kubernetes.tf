data "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                = local.cosmosdb_account_name
  resource_group_name = local.rg_global
}

resource "kubernetes_secret" "project_connection_string_secret" {
  count = var.manage_cosmosdb ? 1 : 0
  metadata {
    name      = var.database_secret_name_project
    namespace = var.database_secret_namespace_project
  }
  data = {
    primary_connection_string = "mongodb://${local.cosmosdb_account_name}:${data.azurerm_cosmosdb_account.cosmosdb_account.primary_key}@${local.cosmosdb_account_name}.mongo.cosmos.azure.com:10255/${var.cosmosdb_database_name_project}?ssl=true&appName=@${local.cosmosdb_account_name}@"
  }

  type = "kubernetes.io/generic"

  depends_on = [module.cosmosdb_database_project]

}
