resource "azurerm_key_vault" "key_vault" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  enabled_for_disk_encryption   = true
  tenant_id                     = var.tenant_id
  soft_delete_retention_days    = var.soft_delete_retention_days
  purge_protection_enabled      = var.purge_protection_enabled
  sku_name                      = var.sku_name
  public_network_access_enabled = var.public_network_access_enabled
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
    key_permissions         = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"]
    secret_permissions      = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
  }
  dynamic "network_acls" {
    for_each = var.key_vault_manage_network_acls ? [1] : []
    content {
      bypass         = "AzureServices"
      default_action = var.key_vault_manage_selected_networks ? "Deny" : "Allow"
    }
    # virtual_network_subnet_ids = var.kv_vnet_subnet_ids
  }
  lifecycle {
    ignore_changes = [tags, access_policy, network_acls]
  }
}

#Alerts created for Key Vault

locals {
  alert_name_critical    = "${var.env_prefix}-${var.env_name}-Critical-Infra"
  alert_name_information = "${var.env_prefix}-${var.env_name}-Information-Infra"
  severity_0             = "0"
  severity_3             = "3"
}

data "azurerm_monitor_action_group" "general" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.env_prefix}-${var.env_name}-agn-alerts-General"
  resource_group_name = "ftds-monitoring-alerts"
}


resource "azurerm_monitor_metric_alert" "availability" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.availability}-${var.name}-${local.alert_name_critical}"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_key_vault.key_vault.id]
  description         = var.descrip_availability
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation
    metric_name      = var.metric_name_availability
    metric_namespace = "Microsoft.KeyVault/vaults"
    operator         = var.operator_less
    threshold        = var.threshold_availability
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.general[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "shoe_box" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.shoe_box}-${var.name}-${local.alert_name_critical}"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_key_vault.key_vault.id]
  description         = var.descrip_shoe_box
  severity            = local.severity_3
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation
    metric_name      = var.metric_name_shoe_box
    metric_namespace = "Microsoft.KeyVault/vaults"
    operator         = var.operator_generic
    threshold        = var.threshold_90
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.general[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "api_hit" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.api_hit}-${var.name}-${local.alert_name_information}"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_key_vault.key_vault.id]
  description         = var.descrip_api_hit
  severity            = local.severity_3
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation
    metric_name      = var.metric_name_api_hit
    metric_namespace = "Microsoft.KeyVault/vaults"
    operator         = var.operator_generic
    threshold        = var.threshold_api_hit
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.general[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

