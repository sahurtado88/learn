locals {
  kvm_active_service_account_name           = "kvm-active-workload-identity"
  kvm_active_fed_id_cred_name               = "kvm_active_fed_id_cred"
  delegation_service_account_name           = "delegation-service-workload-identity"
  delegation_fed_id_cred_name               = "delegation_service_fed_id_cred"
  ra_common_namespace                       = "ra-common"
}

resource "kubernetes_service_account" "delegation_service_sa" {
  count = var.delegation_manage ? 1 : 0
  metadata {
    name      = local.delegation_service_account_name
    namespace = local.ra_common_namespace
    labels = {
      "azure.workload.identity/use" = true
    }
    annotations = {
      "azure.workload.identity/client-id" = module.delegation_service_workload_identity[count.index].client_id
    }
  }
  depends_on = [kubernetes_namespace.namespaces_with_istio_inject]
}

resource "azurerm_federated_identity_credential" "delegation_service_fed_id_cred" {
  count               = var.delegation_manage ? 1 : 0
  name                = local.delegation_fed_id_cred_name
  resource_group_name = local.aks_nrg_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = module.aks.aks_oidc_issuer_url
  parent_id           = module.delegation_service_workload_identity[count.index].id
  subject             = "system:serviceaccount:${local.ra_common_namespace}:${local.delegation_service_account_name}"
}

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


resource "kubernetes_storage_class" "ra-azurefile" {
  metadata {
    name = "ra-azurefile"
    labels = {
      "kubernetes.io/cluster-service" = "true"
    }
  }
  allow_volume_expansion = true
  storage_provisioner    = "kubernetes.io/azure-file"
  reclaim_policy         = "Retain"
  volume_binding_mode    = "Immediate"
  mount_options = [
    "file_mode=0777",
    "dir_mode=0777",
    "uid=1001",
    "gid=1001"
  ]
  parameters = {
    skuName = "Standard_LRS"
  }
}

## Previous

locals {
  ra_system_namespace = "ra-system"
  # gitlab_namespace    = "gitlab"
}

# resource "kubernetes_namespace" "gitlab" {
#   metadata {
#     name = local.gitlab_namespace
#   }
# }

# resource "kubernetes_secret" "gitlab-postgresql" {
#   count = var.gitlab_manage ? 1 : 0
#   metadata {
#     name      = "gitlab-postgresql"
#     namespace = local.gitlab_namespace
#   }

#   data = {
#     username = var.gitlab_pg_admin_username
#     password = var.gitlab_pg_admin_password
#     hostname = module.postgres_gitlab[count.index].pg_fqdn
#   }
#   depends_on = [
#     kubernetes_namespace.namespaces_without_istio_inject
#   ]
#   # type = "opaque" # Default
# }

# resource "kubernetes_secret" "gitlab-praefect-dbsecret" {
#   count = var.gitlab_manage ? 1 : 0
#   metadata {
#     name      = "gitlab-praefect-dbsecret"
#     namespace = local.gitlab_namespace
#   }

#   data = {
#     username = var.gitlab_pg_admin_username
#     secret   = var.gitlab_pg_admin_password
#   }
#   depends_on = [
#     kubernetes_namespace.namespaces_without_istio_inject
#   ]
#   # type = "opaque" # Default
# }

# resource "kubernetes_secret" "gitlab-redis-password" {
#   count = var.gitlab_manage ? 1 : 0
#   metadata {
#     name      = "gitlab-redis-password"
#     namespace = local.gitlab_namespace
#   }

#   data = {
#     secret   = azurerm_redis_cache.redis_cache[count.index].primary_access_key
#     hostname = azurerm_redis_cache.redis_cache[count.index].hostname
#   }
#   depends_on = [
#     kubernetes_namespace.namespaces_without_istio_inject
#   ]
# }
# resource "kubernetes_secret" "gitlab-initial-root-password" {
#   count = var.gitlab_manage ? 1 : 0
#   metadata {
#     name      = "gitlab-initial-root-password"
#     namespace = local.gitlab_namespace
#   }

#   data = {
#     password = var.gitlab_root_password
#   }
#   depends_on = [
#     kubernetes_namespace.namespaces_without_istio_inject
#   ]
# }

#### NOT USED ANYMORE ####

# resource "kubernetes_secret" "cmn_storage_acc_secret" {
#   # We need namespace to be created before we can create a secret
#   # in it.
#   depends_on = [
#     module.cmn_storage_account,
#     kubernetes_namespace.namespaces_with_istio_inject # ra-system namespace
#   ]
#   metadata {
#     name      = "cmn-storage-acc-secret"
#     namespace = local.ra_system_namespace
#   }
#   data = {
#     azurestorageaccountkey  = module.cmn_storage_account.primary_access_key #var.primary_access_key
#     azurestorageaccountname = module.cmn_storage_account.storage_name
#   }
#   type = "kubernetes.io/generic"
# }

# resource "kubernetes_storage_class" "ra-azureblob-gitlab" {
#   count = var.gitlab_manage ? 1 : 0
#   depends_on = [
#     kubernetes_secret.cmn_storage_acc_secret
#   ]
#   metadata {
#     name = "ra-azureblob-gitlab"
#     labels = {
#       "kubernetes.io/cluster-service" = "true"
#     }
#   }

#   storage_provisioner    = "blob.csi.azure.com"
#   reclaim_policy         = "Retain"
#   allow_volume_expansion = true

#   parameters = {
#     skuName                                           = var.gitlab_sc_sku
#     "csi.storage.k8s.io/provisioner-secret-name"      = kubernetes_secret.cmn_storage_acc_secret.metadata[0].name
#     "csi.storage.k8s.io/provisioner-secret-namespace" = local.ra_system_namespace
#     "csi.storage.k8s.io/node-stage-secret-name"       = kubernetes_secret.cmn_storage_acc_secret.metadata[0].name
#     "csi.storage.k8s.io/node-stage-secret-namespace"  = local.ra_system_namespace
#   }

#   mount_options = ["-o gid=1000",
#     "-o uid=1000",
#     "-o allow_other",
#     "-o attr_timeout=120",
#     "-o entry_timeout=120",
#     "-o negative_timeout=120",
#     "--file-cache-timeout-in-seconds=120",
#     "--use-attr-cache=true",
#     "--cancel-list-on-mount-seconds=10",
#     "--cache-size-mb=1000",
#   "--log-level=LOG_WARNING"]
# }

# resource "kubernetes_secret" "racertpod-identity" {
#   count = var.key_vault_manage ? 1 : 0
#   depends_on = [
#     kubernetes_namespace.namespaces_with_istio_inject # ra-system
#   ]
#   metadata {
#     name      = "racertpod-identity"
#     namespace = local.ra_system_namespace
#   }
#   data = {
#     keyvault_name = var.key_vault_name
#     cert_name     = "${replace(var.dns_name_prefix, ".", "-")}-cert"
#   }
#   # type = "opaque" # Default
# }

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


# resource "kubernetes_config_map" "common-storage-config" {
#   count = var.manage_ftbridge ? 1 : 0
#   depends_on = [
#     kubernetes_namespace.namespaces_with_istio_inject
#   ]
#   metadata {
#     name      = "common-storage-config"
#     namespace = local.ra_system_namespace
#   }
#   data = {
#     "config.json" = <<STORAGECONFIG
# {
#   "storageAccount": "${module.cmn_storage_account.storage_name}",
#   "container": "${module.ftbridge_storage_container[count.index].container_name}"
# }
#     STORAGECONFIG
#   }
# }
resource "kubernetes_secret" "keyvault-fthub-auth0token-config" {
  count = var.manage_ftbridge && var.key_vault_manage ? 1 : 0
  depends_on = [
    kubernetes_namespace.namespaces_with_istio_inject
  ]
  metadata {
    name      = "keyvault-fthub-auth0token-config"
    namespace = local.ra_system_namespace
  }

  data = {
    keyvault_name = local.keyvault_name
    key_name      = azurerm_key_vault_secret.fthubauth0token[count.index].name
  }
  # type = "opaque" # Default
}

resource "kubernetes_secret" "keyvault-ftvault-auth0token-config" {
  count = var.manage_ftbridge && var.key_vault_manage ? 1 : 0
  depends_on = [
    kubernetes_namespace.namespaces_with_istio_inject
  ]
  metadata {
    name      = "keyvault-ftvault-auth0token-config"
    namespace = local.ra_system_namespace
  }

  data = {
    keyvault_name = local.keyvault_name
    key_name      = azurerm_key_vault_secret.ftvaultauth0token[count.index].name
  }
  # type = "opaque" # Default
}

resource "kubernetes_secret" "keyvault-ftra-auth0token-config" {
  count = var.manage_ftbridge && var.key_vault_manage ? 1 : 0
  depends_on = [
    kubernetes_namespace.namespaces_with_istio_inject
  ]
  metadata {
    name      = "keyvault-ftra-auth0token-config"
    namespace = local.ra_system_namespace
  }

  data = {
    keyvault_name = local.keyvault_name
    key_name      = azurerm_key_vault_secret.ftraauth0token[count.index].name
  }
  # type = "opaque" # Default
}

# resource "kubernetes_secret" "keyvault-fthub-clientsecret-config" {
#   count = var.manage_ftbridge && var.key_vault_manage ? 1 : 0
#   depends_on = [
#     kubernetes_namespace.namespaces_with_istio_inject
#   ]
#   metadata {
#     name      = "keyvault-fthub-clientsecret-config"
#     namespace = local.ra_system_namespace
#   }
#   data = {
#     keyvault_name = var.key_vault_name
#     key_name      = azurerm_key_vault_secret.fthubclientsecret[count.index].name
#   }
#   # type = "opaque" # Default
# }

# resource "kubernetes_secret" "fthub-keyvault-key-identity" {
#   count = var.key_vault_manage ? 1 : 0
#   depends_on = [
#     kubernetes_namespace.namespaces_with_istio_inject
#   ]
#   metadata {
#     name      = "fthub-keyvault-key-identity"
#     namespace = local.ra_system_namespace
#   }

#   data = {
#     keyvault_name = var.key_vault_name
#     key_name      = "fthub-auth0-token"
#   }
#   # type = "opaque" # Default
# }

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

# catalog connection string

data "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                = local.cosmosdb_account_name
  resource_group_name = local.rg_global
}

resource "kubernetes_secret" "connection_string_secret" {
  count = var.manage_cosmosdb ? 1 : 0
  metadata {
    name      = var.database_secret_name_catalog
    namespace = var.database_secret_namespace_catalog
  }
  data = {
    primary_connection_string = "mongodb://${local.cosmosdb_account_name}:${data.azurerm_cosmosdb_account.cosmosdb_account.primary_readonly_key}@${local.cosmosdb_account_name}.mongo.cosmos.azure.com:10255/${var.cosmosdb_database_name_catalog}?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${local.cosmosdb_account_name}@"
  }

  type       = "kubernetes.io/generic"
  depends_on = [kubernetes_namespace.namespaces_with_istio_inject]
}

resource "kubernetes_secret" "cosmosdb_connection_string_rw_secret" {
  count = var.manage_cosmosdb ? 1 : 0
  metadata {
    name      = var.database_secret_name_cosmosdb_rw
    namespace = var.database_secret_namespace_cosmosdb
  }
  data = {
    primary_readwrite_connection_string   = "mongodb://${local.cosmosdb_account_name}:${data.azurerm_cosmosdb_account.cosmosdb_account.primary_key}@${local.cosmosdb_account_name}.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${local.cosmosdb_account_name}@"
    primary_readonly_connection_string    = "mongodb://${local.cosmosdb_account_name}:${data.azurerm_cosmosdb_account.cosmosdb_account.primary_readonly_key}@${local.cosmosdb_account_name}.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${local.cosmosdb_account_name}@"
    secondary_readwrite_connection_string = "mongodb://${local.cosmosdb_account_name}:${data.azurerm_cosmosdb_account.cosmosdb_account.secondary_key}@${local.cosmosdb_account_name}.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${local.cosmosdb_account_name}@"
    secondary_readonly_connection_string  = "mongodb://${local.cosmosdb_account_name}:${data.azurerm_cosmosdb_account.cosmosdb_account.secondary_readonly_key}@${local.cosmosdb_account_name}.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${local.cosmosdb_account_name}@"
  }

  type       = "kubernetes.io/generic"
  depends_on = [kubernetes_namespace.namespaces_with_istio_inject]
}

resource "kubernetes_secret" "cosmosdb_connection_string_ro_secret" {
  count = var.manage_cosmosdb ? 1 : 0
  metadata {
    name      = var.database_secret_name_cosmosdb_ro
    namespace = var.database_secret_namespace_cosmosdb
  }
  data = {
    primary_readonly_connection_string   = "mongodb://${local.cosmosdb_account_name}:${data.azurerm_cosmosdb_account.cosmosdb_account.primary_key}@${local.cosmosdb_account_name}.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${local.cosmosdb_account_name}@"
    secondary_readonly_connection_string = "mongodb://${local.cosmosdb_account_name}:${data.azurerm_cosmosdb_account.cosmosdb_account.secondary_key}@${local.cosmosdb_account_name}.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${local.cosmosdb_account_name}@"
  }

  type       = "kubernetes.io/generic"
  depends_on = [kubernetes_namespace.namespaces_with_istio_inject]
}

resource "kubernetes_service_account" "kvm_active_sa" {
  metadata {
    name      = local.kvm_active_service_account_name
    namespace = var.base_infra_namespace_with_istio_inject[0]
    labels = {
      "azure.workload.identity/use" = true
    }
    annotations = {
      "azure.workload.identity/client-id" = module.racertpod_identity[0].client_id
    }
  }
  # We need namespace to be created before we can create service account
  # for it. Kubernetes namespace resource does not output name which is
  # required for service account setup, so we need this depends on.
  depends_on = [kubernetes_namespace.namespaces_with_istio_inject]
}

resource "azurerm_federated_identity_credential" "kvm_active_fed_id_cred" {
  name                = local.kvm_active_fed_id_cred_name
  resource_group_name = local.rg_general
  audience            = ["api://AzureADTokenExchange"]
  issuer              = module.aks.aks_oidc_issuer_url
  parent_id           = module.racertpod_identity[0].id
  subject             = "system:serviceaccount:${var.base_infra_namespace_with_istio_inject[0]}:${local.kvm_active_service_account_name}"
}
