locals {
  rg_keyvault   = "${var.env_prefix}-${var.env_name}-rg-keyvault"
  keyvault_name = "${var.env_prefix}-${var.env_name}-keyvault"
}

data "azurerm_key_vault" "akv" {
  name                = local.keyvault_name
  resource_group_name = local.rg_keyvault
}

resource "time_offset" "expiry_period" {
  offset_days = var.secret_expiry_period
}

resource "azurerm_key_vault_secret" "sendgrid_apikey" {
  name         = var.sendgrid_apikey_secret
  content_type = "application/json"
  value = jsonencode({
    "API_KEY" = var.sendgrid_apikey
  })
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
}
