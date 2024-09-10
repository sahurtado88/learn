resource "azurerm_machine_learning_workspace" "global" {
  count                         = var.configure_ml_workspace ? 1 : 0
  name                          = "${var.env_prefix}-aml-workspace"
  location                      = var.location
  resource_group_name           = module.rg.name
  application_insights_id       = module.aml_app_insights[count.index].id
  key_vault_id                  = module.aml_kv[count.index].id
  storage_account_id            = module.aml_sa[count.index].storage_id
  friendly_name                 = "${var.aml_friendly_name}(${var.env_prefix})"
  high_business_impact          = var.aml_high_business_impact
  sku_name                      = var.aml_sku_name
  description                   = var.aml_description
  image_build_compute_name      = "${var.env_prefix}-cpu-compute"
  public_network_access_enabled = var.aml_public_network_access_enabled
  identity {
    type = var.aml_identity_type
  }
  tags = var.tags
}
