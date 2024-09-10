locals {
  rg_global  = "${var.env_prefix}-rg-global"
  rg_general = "${var.env_prefix}-${var.env_name}-rg-general"
}
data "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  resource_group_name = var.aks_rg_name
}

data "azurerm_storage_account" "monitoring_storage" {
  name                = var.monitoring_storage_account_name
  resource_group_name = var.cluster_index == "245" ? local.rg_global : local.rg_general
}

// Containers for monitoring data:
// tempo - created here. Tempo services require the container to be pre-created
// thanos - created by a Thanos server
// loki - created in the original tf workflows (base, etc.) 
// loki-ruler - created here. Even though it is not used, loki requires it to exist
// NOTE that we cannot move the creation of loki here, since the loki container
// would be destroyed the next time we ran the corresponding original pipeline over
// the existing clusters.

module "tempo_storage_container" {
  source         = "../../modules/storage_container"
  storage_name   = var.monitoring_storage_account_name
  container_name = "tempo-${var.aks_name}"
}

module "loki_ruler_storage_container" {
  source         = "../../modules/storage_container"
  storage_name   = var.monitoring_storage_account_name
  container_name = "loki-ruler-${var.aks_name}"
}

resource "kubernetes_secret" "sa_secret" {
  metadata {
    name      = var.monitoring_secret_name
    namespace = var.monitoring_secret_namespace
  }

  data = {
    account_key               = data.azurerm_storage_account.monitoring_storage.primary_access_key
    account_name              = var.monitoring_storage_account_name
    loki_container_name       = "loki-${var.aks_name}"
    loki_ruler_container_name = "loki-ruler-${var.aks_name}"
    thanos_container_name     = "thanos-${var.aks_name}"
    tempo_container_name      = "tempo-${var.aks_name}"
  }

  type = "kubernetes.io/generic"
}
