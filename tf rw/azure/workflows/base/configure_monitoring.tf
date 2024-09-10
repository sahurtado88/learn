module "loki_storage_container" {
  source       = "../../modules/storage_container"
  storage_name = var.monitoring_storage_account_name
  # assuming aks_cluster_name is unique within the subscription
  # otherwise, need to add more pieces to the name (resource group, tag value, etc.)
  container_name = "loki-${module.aks.aks_name}"
}
