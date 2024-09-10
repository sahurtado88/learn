module "monitoring_storage_account" {
  count  = var.manage_monitoring ? 1 : 0
  source = "../../modules/storage_account"
  # rg_name          = module.monitoring_rg[count.index].name
  rg_name          = local.rg_global
  storage_name     = var.monitoring_storage_account_name
  replication_type = var.monitoring_storage_replication_type
  location         = var.location
  # tags             = var.tags
  storage_manage_network = var.storage_account_manage_selected_networks
  storage_network_access = var.storage_account_manage_pep ? "Deny" : "Allow"
  # storage_subnet_ids     = [data.azurerm_subnet.base-endpoint.id, data.azurerm_subnet.endpoint.id]
  #variables for Azure monitor
  env_name      = "${var.env_name}-${var.gitlab_instance}"
  env_prefix    = var.env_prefix
  alerts_manage = var.alerts_manage
}

# container for loki running in the common cluster
module "loki_storage_container" {
  count        = var.manage_monitoring ? 1 : 0
  source       = "../../modules/storage_container"
  storage_name = module.monitoring_storage_account[0].storage_name
  # assuming aks_cluster_name is unique within the subscription
  # otherwise, need to add more pieces to the name (resource group, tag value, etc.)
  container_name = "loki-${module.aks.aks_name}"
  depends_on = [
    module.monitoring_sa_pep_internal
  ]
}

