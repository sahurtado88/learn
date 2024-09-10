resource "kubernetes_secret" "common_sa_secret" {
  metadata {
    name      = "az-tenant-sa-secret"
    namespace = var.sa_secret_namespace_project
  }
  data = {
    azurestorageaccountkey  = data.azurerm_storage_account.monitoring_storage_account.primary_access_key #var.primary_access_key
    azurestorageaccountname = var.monitoring_storage_account_name
  }
  type = "kubernetes.io/generic"
}

resource "kubernetes_storage_class" "ra-azureblob" {
  depends_on = [
    kubernetes_secret.common_sa_secret
  ]
  metadata {
    name = join("-", ["ra-blob", var.sa_secret_namespace_project])
    labels = {
      "kubernetes.io/cluster-service" = "true"
    }
  }

  storage_provisioner    = "blob.csi.azure.com"
  reclaim_policy         = "Retain"
  allow_volume_expansion = true

  parameters = {
    "csi.storage.k8s.io/provisioner-secret-name"      = data.azurerm_storage_account.monitoring_storage_account.name
    "csi.storage.k8s.io/provisioner-secret-namespace" = var.sa_secret_namespace_project
    "csi.storage.k8s.io/node-stage-secret-name"       = data.azurerm_storage_account.monitoring_storage_account.name
    "csi.storage.k8s.io/node-stage-secret-namespace"  = var.sa_secret_namespace_project
  }
}
