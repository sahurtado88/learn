resource "kubernetes_namespace" "namespaces_with_istio_inject" {
  count = length(var.base_infra_namespace_with_istio_inject)
  metadata {
    labels = {
      app             = var.base_infra_namespace_with_istio_inject[count.index]
      istio-injection = "enabled"
    }
    name = var.base_infra_namespace_with_istio_inject[count.index]
  }
}

resource "kubernetes_namespace" "namespaces_without_istio_inject" {
  count = length(var.base_infra_namespace_without_istio_inject)
  metadata {
    labels = {
      app = var.base_infra_namespace_without_istio_inject[count.index]
    }
    name = var.base_infra_namespace_without_istio_inject[count.index]
  }
}

## Previous

locals {
  ra_system_namespace = "ra-system"
  gitlab_namespace    = "gitlab"
}

# resource "kubernetes_namespace" "gitlab" {
#   metadata {
#     name = local.gitlab_namespace
#   }
# }

resource "kubernetes_secret" "gitlab-postgresql" {
  count = var.gitlab_manage ? 1 : 0
  metadata {
    name      = "gitlab-postgresql"
    namespace = local.gitlab_namespace
  }

  data = {
    username = var.gitlab_pg_admin_username
    password = var.gitlab_pg_admin_password
    hostname = module.postgres_gitlab[count.index].pg_fqdn
  }
  depends_on = [
    kubernetes_namespace.namespaces_without_istio_inject
  ]
  # type = "opaque" # Default
}

resource "kubernetes_secret" "gitlab-praefect-dbsecret" {
  count = var.gitlab_manage ? 1 : 0
  metadata {
    name      = "gitlab-praefect-dbsecret"
    namespace = local.gitlab_namespace
  }

  data = {
    username = var.gitlab_pg_admin_username
    secret   = var.gitlab_pg_admin_password
  }
  depends_on = [
    kubernetes_namespace.namespaces_without_istio_inject
  ]
  # type = "opaque" # Default
}

resource "kubernetes_secret" "gitlab-redis-password" {
  count = var.gitlab_manage ? 1 : 0
  metadata {
    name      = "gitlab-redis-password"
    namespace = local.gitlab_namespace
  }

  data = {
    secret   = azurerm_redis_cache.redis_cache[count.index].primary_access_key
    hostname = azurerm_redis_cache.redis_cache[count.index].hostname
  }
  depends_on = [
    kubernetes_namespace.namespaces_without_istio_inject
  ]
}
resource "kubernetes_secret" "gitlab-initial-root-password" {
  count = var.gitlab_manage ? 1 : 0
  metadata {
    name      = "gitlab-initial-root-password"
    namespace = local.gitlab_namespace
  }

  data = {
    password = var.gitlab_root_password
  }
  depends_on = [
    kubernetes_namespace.namespaces_without_istio_inject
  ]
}

resource "kubernetes_secret" "cmn_storage_acc_secret" {
  # We need namespace to be created before we can create a secret
  # in it.
  depends_on = [
    module.global_storage_account,
    kubernetes_namespace.namespaces_with_istio_inject # ra-system namespace
  ]
  metadata {
    name      = "cmn-storage-acc-secret"
    namespace = local.ra_system_namespace
  }
  data = {
    azurestorageaccountkey  = module.global_storage_account.primary_access_key #var.primary_access_key
    azurestorageaccountname = module.global_storage_account.storage_name
  }
  type = "kubernetes.io/generic"
}

resource "kubernetes_secret" "backup-azure-creds" {
  count = var.gitlab_manage ? 1 : 0

  depends_on = [
    module.global_storage_account,
    kubernetes_namespace.namespaces_with_istio_inject # ra-system namespace
  ]
  metadata {
    name      = "backup-azure-creds"
    namespace = local.gitlab_namespace
  }
  data = {
    config = yamlencode({
      provider                   = "AzureRM"
      azure_storage_account_name = module.global_storage_account.storage_name
      azure_storage_access_key   = module.global_storage_account.primary_access_key
      azure_storage_domain       = "blob.core.windows.net"
    })
  }
}
resource "kubernetes_storage_class" "ra-azuredisk-gitlab" {
  count = var.gitlab_manage ? 1 : 0
  depends_on = [
    kubernetes_secret.cmn_storage_acc_secret
  ]
  metadata {
    name = "ra-azuredisk-gitlab"
    labels = {
      "kubernetes.io/cluster-service" = "true"
    }
  }

  storage_provisioner    = "disk.csi.azure.com"
  reclaim_policy         = "Retain"
  allow_volume_expansion = true

  parameters = {
    skuName                                           = "Premium_LRS"
    "csi.storage.k8s.io/provisioner-secret-name"      = kubernetes_secret.cmn_storage_acc_secret.metadata[0].name
    "csi.storage.k8s.io/provisioner-secret-namespace" = local.ra_system_namespace
    "csi.storage.k8s.io/node-stage-secret-name"       = kubernetes_secret.cmn_storage_acc_secret.metadata[0].name
    "csi.storage.k8s.io/node-stage-secret-namespace"  = local.ra_system_namespace
  }
}
resource "kubernetes_secret" "keyvault-cert-public-config" {
  count = var.key_vault_manage ? 1 : 0
  depends_on = [
    kubernetes_namespace.namespaces_with_istio_inject
  ]
  metadata {
    name      = "keyvault-cert-public-config"
    namespace = local.ra_system_namespace
  }

  data = {
    keyvault_name = local.keyvault_name
    key_name      = "${replace(var.dns_name_prefix, ".", "-")}-cert"
  }
  # type = "opaque" # Default
}
resource "kubernetes_secret" "keyvault-cert-private-config" {
  count = var.key_vault_manage ? 1 : 0
  depends_on = [
    kubernetes_namespace.namespaces_with_istio_inject
  ]
  metadata {
    name      = "keyvault-cert-private-config"
    namespace = local.ra_system_namespace
  }

  data = {
    keyvault_name = local.keyvault_name
    key_name      = "ftds-private-cert"
  }
  # type = "opaque" # Default
}


resource "kubernetes_secret" "azuredns_sp" {
  # We need monitoring ns to be created before we can create secrets in it.
  # Kubernetes namespace resource does not output name which is still not
  # much help since the input ns is an array, thus we have depends_on
  depends_on = [kubernetes_namespace.namespaces_with_istio_inject]
  metadata {
    name      = "azuredns-sp"
    namespace = "ra-system"
  }
  data = {
    client-secret = var.azuredns_client_secret
  }

  type = "kubernetes.io/generic"
}

resource "kubernetes_secret" "azuredns_sp_private" {
  # We need monitoring ns to be created before we can create secrets in it.
  # Kubernetes namespace resource does not output name which is still not
  # much help since the input ns is an array, thus we have depends_on
  depends_on = [kubernetes_namespace.namespaces_with_istio_inject]
  metadata {
    name      = "azuredns-sp-private"
    namespace = "ra-system"
  }
  data = {
    client-secret = var.azure_client_secret
  }

  type = "kubernetes.io/generic"
}

resource "kubernetes_secret" "azure_spn_ftds_swc" {
  # We need monitoring ns to be created before we can create secrets in it.
  # Kubernetes namespace resource does not output name which is still not
  # much help since the input ns is an array, thus we have depends_on
  depends_on = [kubernetes_namespace.namespaces_with_istio_inject]
  metadata {
    name      = "azure-spn-ftds-swc"
    namespace = "ra-system"
  }
  data = {
    client-secret = var.azure_swc_client_secret
  }

  type = "kubernetes.io/generic"
}
