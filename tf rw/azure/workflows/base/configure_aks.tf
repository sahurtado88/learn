
data "azurerm_container_registry" "acr" {
  provider            = azurerm.global_svcs
  name                = var.acr_name
  resource_group_name = local.rg_global
}

data "azurerm_log_analytics_workspace" "insights" {
  count               = var.log_analytics_manage ? 1 : 0
  name                = local.log_analytics_name
  resource_group_name = local.rg_general
}

data "azurerm_resource_group" "common_network_rg" {
  name = local.rg_network
}

data "azurerm_resource_group" "aks_cluster_rg" {
  name       = format(local.aks_nrg_name, var.cluster_index)
  depends_on = [module.aks]
}

module "whitelist" {
  source = "../../modules/whitelist"
}

module "aks" {
  source = "../../modules/aks"
  #GENERAL
  # tags            = var.tags
  location        = var.location
  aks_rg_name     = local.aks_rg_name
  aks_nrg_name    = format(local.aks_nrg_name, var.cluster_index)
  network_rg_name = local.rg_network

  #AKS
  aks_name                  = local.aks_name
  aks_vnet_name             = format(local.aks_vnet_name, (floor(var.cluster_index / 4)))
  aks_subnet_name           = local.aks_subnet_name
  aks_subnet_address_prefix = "10.${floor(var.cluster_index / 2) + (var.env_index * (floor((var.env_max_clusters - 1) / 20) + 1) * 10)}.${var.cluster_index % 2 == 0 ? 0 : 128}.0/18"

  # Default pool
  node_pool_name              = var.node_pool_name
  node_pool_type              = var.node_pool_type
  node_pool_vm_size           = var.node_pool_vm_size
  node_pool_count             = var.node_pool_count
  os_disk_size_gb             = var.os_disk_size_gb
  node_pool_availability_zone = var.node_pool_availability_zone
  node_pool_max_count         = var.node_pool_max_count
  node_pool_min_count         = var.node_pool_min_count
  max_pods                    = var.node_pool_max_pods

  # Workspace node pool
  base_manage           = var.base_manage
  node_pool_vm_size_wks = var.node_pool_vm_size_wks
  max_pods_wks          = var.node_pool_max_pods_wks
  os_disk_size_gb_wks   = var.os_disk_size_gb_wks

  dns_prefix        = var.dns_prefix
  load_balancer_sku = var.load_balancer_sku
  # aks_lb_publicip_name            = format(local.aks_lb_publicip_name, var.cluster_index)
  network_plugin                  = var.network_plugin
  api_server_authorized_ip_ranges = module.whitelist.whitelist_infra_ip_range
  container_insights_manage       = var.container_insights_manage

  sku_tier           = var.aks_sku_tier
  kubernetes_version = var.kubernetes_version

  # Windows node pool
  windows_support       = var.windows_support
  win_node_pool_name    = var.win_node_pool_name
  node_pool_vm_size_win = var.node_pool_vm_size_win
  max_pods_win          = var.node_pool_max_pods_win
  os_disk_size_gb_win   = var.os_disk_size_gb_win
  os_sku_win            = var.os_sku_win

  # Windows test node pool (ftecho)
  windows_test_support       = var.windows_test_support
  win_test_node_pool_name    = var.win_test_node_pool_name
  node_pool_vm_size_win_test = var.node_pool_vm_size_win_test
  max_pods_win_test          = var.node_pool_max_pods_win_test
  os_disk_size_gb_win_test   = var.os_disk_size_gb_win_test
  os_sku_win_test            = var.os_sku_win_test

  # log_analytics_manage       = var.log_analytics_manage
  # log_analytics_name         = var.log_analytics_manage ? data.azurerm_log_analytics_workspace.insights[0].name : null
  log_analytics_workspace_id = var.log_analytics_manage ? data.azurerm_log_analytics_workspace.insights[0].id : null

  #variables for Azure monitor
  env_name      = var.env_name
  env_prefix    = var.env_prefix
  alerts_manage = var.alerts_manage

  depends_on = [
    module.whitelist
  ]
}

resource "azurerm_role_assignment" "network_contributor" {
  scope                = data.azurerm_resource_group.common_network_rg.id
  role_definition_name = "Network Contributor"
  principal_id         = module.aks.aks_managed_identity_principal_id
}

resource "azurerm_role_assignment" "network_contributor_aks_rg" {
  scope                = data.azurerm_resource_group.aks_cluster_rg.id
  role_definition_name = "Network Contributor"
  principal_id         = module.aks.aks_managed_identity_principal_id
  depends_on           = [module.aks]
}

resource "azurerm_role_assignment" "network_contributor_aks_pip" {
  scope                = module.aks.aks_lb_pip_id
  role_definition_name = "Network Contributor"
  principal_id         = module.aks.aks_managed_identity_principal_id
  depends_on           = [module.aks]
}

resource "azurerm_role_assignment" "attach_acr" {
  depends_on = [module.aks]
  # principal needs to be kubelet identity - 
  #  see https://stackoverflow.com/questions/59978060/how-to-give-permissions-to-aks-to-access-acr-via-terraform
  principal_id                     = module.aks.aks_kubelet_identity
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

resource "azurerm_key_vault_access_policy" "akv_aks" {
  # provider     = azurerm.global_svcs
  key_vault_id = data.azurerm_key_vault.akv.id
  tenant_id    = data.azurerm_key_vault.akv.tenant_id
  object_id    = module.aks.keyvault_secret_identity.object_id

  certificate_permissions = ["Get", "List"]
  secret_permissions      = ["Get", "List"]
}
resource "azurerm_key_vault_access_policy" "global_akv_aks" {
  key_vault_id = data.azurerm_key_vault.global_akv.id
  tenant_id    = data.azurerm_key_vault.global_akv.tenant_id
  object_id    = module.aks.keyvault_secret_identity.object_id

  certificate_permissions = ["Get", "List"]
  secret_permissions      = ["Get", "List"]
}