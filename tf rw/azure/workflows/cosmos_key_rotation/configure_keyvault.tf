resource "time_offset" "expiry_period" {
  offset_days = var.secret_expiry_period
}

resource "azurerm_key_vault_secret" "cosmos_primary_ro" {
  count           = var.key_vault_manage ? 1 : 0
  name            = var.cosmosdb-primary-readonly-connection-string
  value           = "mongodb://${local.cosmosdb_account_name}:${data.azurerm_cosmosdb_account.cosmosdb_account.primary_readonly_key}@${local.cosmosdb_account_name}.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${local.cosmosdb_account_name}@"
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
}

resource "azurerm_key_vault_secret" "cosmos_secondary_ro" {
  count           = var.key_vault_manage ? 1 : 0
  name            = var.cosmosdb-secondary-readonly-connection-string
  value           = "mongodb://${local.cosmosdb_account_name}:${data.azurerm_cosmosdb_account.cosmosdb_account.secondary_readonly_key}@${local.cosmosdb_account_name}.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${local.cosmosdb_account_name}@"
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
}

resource "azurerm_key_vault_secret" "cosmos_primary_rw" {
  count           = var.key_vault_manage ? 1 : 0
  name            = var.cosmosdb-primary-readwrite-connection-string
  value           = "mongodb://${local.cosmosdb_account_name}:${data.azurerm_cosmosdb_account.cosmosdb_account.primary_key}@${local.cosmosdb_account_name}.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${local.cosmosdb_account_name}@"
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
}

resource "azurerm_key_vault_secret" "cosmos_secondary_rw" {
  count           = var.key_vault_manage ? 1 : 0
  name            = var.cosmosdb-secondary-readwrite-connection-string
  value           = "mongodb://${local.cosmosdb_account_name}:${data.azurerm_cosmosdb_account.cosmosdb_account.secondary_key}@${local.cosmosdb_account_name}.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${local.cosmosdb_account_name}@"
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
}