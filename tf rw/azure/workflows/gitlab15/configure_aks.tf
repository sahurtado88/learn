data "azurerm_container_registry" "acr" {
  provider            = azurerm.global_svcs
  name                = var.acr_name
  resource_group_name = local.rg_global
}
data "azurerm_log_analytics_workspace" "insights" {
  count               = var.log_analytics_manage ? 1 : 0
  name                = local.log_analytics_name
  resource_group_name = local.rg_global
}

data "azurerm_resource_group" "aks_cluster_rg" {
  name       = local.aks_nrg_name
  depends_on = [module.aks]
}

module "whitelist" {
  source = "../../modules/whitelist"
}

resource "azurerm_resource_group" "gitlab_aks_rg" {
  name     = local.aks_rg_name
  location = var.location
}
module "aks" {
  source = "../../modules/aks"
  #GENERAL
  # tags            = var.tags
  location        = var.location
  aks_rg_name     = local.aks_rg_name
  aks_nrg_name    = local.aks_nrg_name
  network_rg_name = local.rg_network

  #AKS
  aks_name                  = local.aks_name
  aks_vnet_name             = local.aks_vnet_name
  aks_subnet_name           = local.aks_subnet_name
  aks_subnet_address_prefix = "10.245.${104 + var.gitlab_network_block * 4}.0/22"

  # Default pool
  node_pool_name              = var.node_pool_name
  node_pool_type              = var.node_pool_type
  node_pool_vm_size           = var.node_pool_vm_size
  node_pool_count             = var.node_pool_count
  os_disk_size_gb             = var.os_disk_size_gb
  node_pool_availability_zone = var.node_pool_availability_zone
  node_pool_max_count         = var.node_pool_max_count
  node_pool_min_count         = var.node_pool_min_count

  dns_prefix        = var.dns_prefix
  load_balancer_sku = var.load_balancer_sku
  # aks_lb_publicip_name            = local.global_aks_lb_publicip
  network_plugin                  = var.network_plugin
  api_server_authorized_ip_ranges = module.whitelist.whitelist_infra_ip_range
  container_insights_manage       = var.container_insights_manage

  windows_support    = var.windows_support
  win_node_pool_name = var.win_node_pool_name
  sku_tier           = var.aks_sku_tier
  kubernetes_version = var.kubernetes_version

  # log_analytics_manage       = var.log_analytics_manage
  # log_analytics_name         = var.log_analytics_manage ? data.azurerm_log_analytics_workspace.insights[0].name : null
  log_analytics_workspace_id = var.log_analytics_manage ? data.azurerm_log_analytics_workspace.insights[0].id : null

  #variables for Azure monitor
  env_name      = "${var.env_name}-${var.gitlab_instance}"
  env_prefix    = var.env_prefix
  alerts_manage = var.alerts_manage

  depends_on = [
    module.whitelist, azurerm_resource_group.gitlab_aks_rg
  ]
}

resource "azurerm_role_assignment" "network_contributor" {
  scope                = data.azurerm_virtual_network.common_vnet.id
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
