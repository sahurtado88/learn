locals {
  rg_name = "ftds-monitoring-alerts"
}

data "azurerm_subscription" "current" {
  subscription_id = var.subscription_id
}

module "rg_monitoring" {
  count    = var.alerts_manage ? 1 : 0
  source   = "../../modules/resource_group"
  rg_name  = local.rg_name
  location = var.location
  tags     = var.tags
}

#Create action groups for Alerts-subscription
#Gateways

module "actiongroup_gw" {
  count               = var.alerts_manage ? 1 : 0
  source              = "../../modules/alerts_actiongroup"
  actiongroup_suffix  = "GW"
  env_name            = var.env_name
  env_prefix          = var.env_prefix
  actiongroup_rg      = module.rg_monitoring[0].name
  webhook_service_uri = var.service_uri_appgw
  alert_subs          = true
}

#Databases 

module "actiongroup_db" {
  count               = var.alerts_manage ? 1 : 0
  source              = "../../modules/alerts_actiongroup"
  actiongroup_suffix  = "DB"
  env_name            = var.env_name
  env_prefix          = var.env_prefix
  actiongroup_rg      = module.rg_monitoring[0].name
  webhook_service_uri = var.service_uri_db
  alert_subs          = true
}

#K8s

module "actiongroup_k8s" {
  count               = var.alerts_manage ? 1 : 0
  source              = "../../modules/alerts_actiongroup"
  actiongroup_suffix  = "K8S"
  env_name            = var.env_name
  env_prefix          = var.env_prefix
  actiongroup_rg      = module.rg_monitoring[0].name
  webhook_service_uri = var.service_uri_aks
  alert_subs          = true
}

#Networking

module "actiongroup_net" {
  count               = var.alerts_manage ? 1 : 0
  source              = "../../modules/alerts_actiongroup"
  actiongroup_suffix  = "NET"
  env_name            = var.env_name
  env_prefix          = var.env_prefix
  actiongroup_rg      = module.rg_monitoring[0].name
  webhook_service_uri = var.service_uri_network
  alert_subs          = true
}

#Storage Accounts

module "actiongroup_sa" {
  count               = var.alerts_manage ? 1 : 0
  source              = "../../modules/alerts_actiongroup"
  actiongroup_suffix  = "SAS"
  env_name            = var.env_name
  env_prefix          = var.env_prefix
  actiongroup_rg      = module.rg_monitoring[0].name
  webhook_service_uri = var.service_uri_sa
  alert_subs          = true
}

#Security

module "actiongroup_sec" {
  count               = var.alerts_manage ? 1 : 0
  source              = "../../modules/alerts_actiongroup"
  actiongroup_suffix  = "SEC"
  env_name            = var.env_name
  env_prefix          = var.env_prefix
  actiongroup_rg      = module.rg_monitoring[0].name
  webhook_service_uri = var.service_uri_security
  alert_subs          = true
}

#Vault

module "actiongroup_vault" {
  count               = var.alerts_manage ? 1 : 0
  source              = "../../modules/alerts_actiongroup"
  actiongroup_suffix  = "VAULT_S"
  env_name            = var.env_name
  env_prefix          = var.env_prefix
  actiongroup_rg      = module.rg_monitoring[0].name
  webhook_service_uri = var.service_uri_vault
  alert_subs          = true
}

#Create Services Health
resource "azurerm_monitor_activity_log_alert" "service_health" {
  count               = var.alerts_manage ? 1 : 0
  name                = "Azure Global Service Health"
  resource_group_name = local.rg_name
  scopes              = [data.azurerm_subscription.current.id]
  criteria {
    category = "ServiceHealth"
    service_health {
      locations = var.sh_location
      services  = var.sh_services
      events    = var.sh_events
    }
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

# Delete modules Azure alerts

module "sa_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Azure Storage Account"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.Storage/storageAccounts/delete"
  action_group_id   = module.actiongroup_sa[0].action_group_id
}

module "vmss_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Virtual Machine Scale Sets"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.Compute/virtualMachineScaleSets/delete"
  action_group_id   = module.actiongroup_k8s[0].action_group_id
}

module "dns_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Azure DNS Zone"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.Network/privateDnsZones/delete"
  action_group_id   = module.actiongroup_net[0].action_group_id
}

module "nic_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Azure Network Interface"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.Network/networkInterfaces/delete"
  action_group_id   = module.actiongroup_net[0].action_group_id
}

module "appgw_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Application Gateways"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.Network/applicationGateways/delete"
  action_group_id   = module.actiongroup_gw[0].action_group_id
}

module "lb_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Load Balancer"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.Network/loadBalancers/delete"
  action_group_id   = module.actiongroup_net[0].action_group_id
}

module "aks_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Managed Cluster-AKS"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.ContainerService/managedClusters/delete"
  action_group_id   = module.actiongroup_k8s[0].action_group_id
}

module "nsg_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Network Security Group"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.Network/networkSecurityGroups/delete"
  action_group_id   = module.actiongroup_net[0].action_group_id
}

module "pip_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Public Ip Address"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.Network/publicIPAddresses/delete"
  action_group_id   = module.actiongroup_net[0].action_group_id
}

module "kv_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Key Vault"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.KeyVault/vaults/delete"
  action_group_id   = module.actiongroup_vault[0].action_group_id
}

module "function_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Azure Functions"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.Web/sites/delete"
  action_group_id   = module.actiongroup_k8s[0].action_group_id
}

module "cosmodb_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "CosmosDB"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.HealthcareApis/services/delete"
  action_group_id   = module.actiongroup_db[0].action_group_id
}

module "postgres_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Postgres"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.DBforPostgreSQL/flexibleServers/delete"
  action_group_id   = module.actiongroup_db[0].action_group_id
}

module "pep_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "PrivateEndPoints"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.Network/privateEndpoints/delete"
  action_group_id   = module.actiongroup_net[0].action_group_id
}

module "rediscache_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Redis Cache"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.Cache/redis/delete"
  action_group_id   = module.actiongroup_db[0].action_group_id
}

module "backup_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Backup Vaults Instance"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.DataProtection/backupVaults/backupInstances/delete"
  action_group_id   = module.actiongroup_vault[0].action_group_id
}

module "backup_vault_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Backup Vaults"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.DataProtection/backupVaults/delete"
  action_group_id   = module.actiongroup_vault[0].action_group_id
}

module "security_group_rule_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Security Group Rule"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.Network/networkSecurityGroups/securityRules/delete"
  action_group_id   = module.actiongroup_net[0].action_group_id
}

module "policy_assignment_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Policy Assignment"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.Authorization/policyAssignments/delete"
  action_group_id   = module.actiongroup_sec[0].action_group_id
}

module "security_solution_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "Security Solution"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.Security/securitySolutions/delete"
  action_group_id   = module.actiongroup_sec[0].action_group_id
}

module "sql_server_firewall_rule_delete" {
  count             = var.alerts_manage ? 1 : 0
  source            = "../../modules/alerts_delete"
  alert_name_suffix = "SQL Server Firewall Rule"
  rg_name_delete    = module.rg_monitoring[0].name
  env_name          = var.env_name
  subscription_id   = data.azurerm_subscription.current.id
  operation_name    = "Microsoft.Sql/servers/firewallRules/delete"
  action_group_id   = module.actiongroup_net[0].action_group_id
}

# Stop/Restarted Azure components

module "stop_aks_cluster" {
  count                = var.alerts_manage ? 1 : 0
  source               = "../../modules/alerts_delete"
  alert_name_suffix    = "Managed AKS Cluster"
  label_operation_name = "Stop"
  rg_name_delete       = module.rg_monitoring[0].name
  env_name             = var.env_name
  subscription_id      = data.azurerm_subscription.current.id
  operation_name       = "Microsoft.ContainerService/managedClusters/stop/action"
  action_group_id      = module.actiongroup_k8s[0].action_group_id
}

module "stop_function" {
  count                = var.alerts_manage ? 1 : 0
  source               = "../../modules/alerts_delete"
  alert_name_suffix    = "Azure Function"
  label_operation_name = "Stop"
  rg_name_delete       = module.rg_monitoring[0].name
  env_name             = var.env_name
  subscription_id      = data.azurerm_subscription.current.id
  operation_name       = "Microsoft.Web/sites/stop/Action"
  action_group_id      = module.actiongroup_k8s[0].action_group_id
}

module "stop_redis_cache" {
  count                = var.alerts_manage ? 1 : 0
  source               = "../../modules/alerts_delete"
  alert_name_suffix    = "Redis Cache"
  label_operation_name = "Stop"
  rg_name_delete       = module.rg_monitoring[0].name
  env_name             = var.env_name
  subscription_id      = data.azurerm_subscription.current.id
  operation_name       = "Microsoft.Cache/redis/stop/action"
  action_group_id      = module.actiongroup_db[0].action_group_id
}

module "deallocate_vmss" {
  count                = var.alerts_manage ? 1 : 0
  source               = "../../modules/alerts_delete"
  alert_name_suffix    = "Virtual Machine Scale Set"
  label_operation_name = "Deallocate"
  rg_name_delete       = module.rg_monitoring[0].name
  env_name             = var.env_name
  subscription_id      = data.azurerm_subscription.current.id
  operation_name       = "Microsoft.Compute/virtualMachineScaleSets/deallocate/action"
  action_group_id      = module.actiongroup_k8s[0].action_group_id
}

module "restarted_vmss" {
  count                = var.alerts_manage ? 1 : 0
  source               = "../../modules/alerts_delete"
  alert_name_suffix    = "Virtual Machine Scale Set"
  label_operation_name = "Restarted"
  rg_name_delete       = module.rg_monitoring[0].name
  env_name             = var.env_name
  subscription_id      = data.azurerm_subscription.current.id
  operation_name       = "Microsoft.Compute/virtualMachineScaleSets/restart/action"
  action_group_id      = module.actiongroup_k8s[0].action_group_id
}
