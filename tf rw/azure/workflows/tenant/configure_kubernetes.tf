resource "kubernetes_namespace" "kub_tenant_namespace" {
  metadata {
    annotations = {
      name = var.tenant
    }
    labels = {
      istio-injection = "enabled"
    }
    name = var.tenant
  }
}


resource "kubernetes_secret" "tenant_sa_secret" {
  # We need namespace to be created before we can create a secret
  # in it.
  depends_on = [
    kubernetes_namespace.kub_tenant_namespace
  ]
  metadata {
    name      = "az-tenant-sa-secret"
    namespace = var.tenant
  }
  data = {
    azurestorageaccountkey  = module.storageaccount.primary_access_key #var.primary_access_key
    azurestorageaccountname = module.storageaccount.storage_name
  }
  type = "kubernetes.io/generic"
}

resource "kubernetes_storage_class" "ra-azureblob" {
  depends_on = [
    kubernetes_secret.tenant_sa_secret
  ]
  metadata {
    name = join("-", ["ra-blob", var.tenant])
    labels = {
      "kubernetes.io/cluster-service" = "true"
    }
  }

  storage_provisioner    = "blob.csi.azure.com"
  reclaim_policy         = "Retain"
  allow_volume_expansion = true

  parameters = {
    skuName                                           = var.tenant_storage_replication_type
    "csi.storage.k8s.io/provisioner-secret-name"      = kubernetes_secret.tenant_sa_secret.metadata[0].name
    "csi.storage.k8s.io/provisioner-secret-namespace" = var.tenant
    "csi.storage.k8s.io/node-stage-secret-name"       = kubernetes_secret.tenant_sa_secret.metadata[0].name
    "csi.storage.k8s.io/node-stage-secret-namespace"  = var.tenant
  }
}


resource "kubernetes_manifest" "secret_provider_class" {

  depends_on = [
    kubernetes_namespace.kub_tenant_namespace
  ]

  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "${var.tenant}-akv-spc"
      "namespace" = var.tenant
    }
    "spec" = {
      "parameters" = {
        "keyvaultName"           = local.keyvault_name
        "objects"                = <<-EOT
      array:
        - |
          objectName: "${replace(var.dns_name_prefix, ".", "-")}-cert"
          objectType: secret
          objectVersion: ""
      
      EOT
        "tenantId"               = var.az_tenant_id
        "usePodIdentity"         = "false"
        "useVMManagedIdentity"   = "true"
        "userAssignedIdentityID" = data.azurerm_user_assigned_identity.azurekeyvaultsecretsprovider.client_id
      }
      "provider" = "azure"
      "secretObjects" = [
        {
          "data" = [
            {
              "key"        = "tls.key"
              "objectName" = "${replace(var.dns_name_prefix, ".", "-")}-cert"
            },
            {
              "key"        = "tls.crt"
              "objectName" = "${replace(var.dns_name_prefix, ".", "-")}-cert"
            },
          ]
          "secretName" = replace(var.dns_name_prefix, ".", "-")
          "type"       = "kubernetes.io/tls"
        },
      ]
    }
  }

}

resource "kubernetes_manifest" "secret_provider_class_ftra_auth0_token" {

  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "${var.ftra-auth0-token-secret}-akv-spc"
      "namespace" = var.tenant
    }
    "spec" = {
      "parameters" = {
        "keyvaultName"           = local.keyvault_name
        "objects"                = <<-EOT
      array:
        - |
          objectName: ${var.ftra-auth0-token-secret}                
          objectType: secret
          objectVersion: ""
      
      EOT
        "tenantId"               = var.az_tenant_id
        "usePodIdentity"         = "false"
        "useVMManagedIdentity"   = "true"
        "userAssignedIdentityID" = data.azurerm_user_assigned_identity.azurekeyvaultsecretsprovider.client_id
      }
      "provider" = "azure"
      "secretObjects" = [
        {
          "data" = [
            {
              "key"        = var.ftra-auth0-token-secret
              "objectName" = var.ftra-auth0-token-secret
            }
          ]
          "secretName" = var.ftra-auth0-token-secret
          "type"       = "Opaque"
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "secret_provider_class_sendgrid_api_key" {
  count = var.sendgrid_manage ? 1 : 0
  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "${var.sendgrid_apikey_secret}-spc"
      "namespace" = var.tenant
    }
    "spec" = {
      "parameters" = {
        "keyvaultName"           = local.keyvault_name
        "objects"                = <<-EOT
      array:
        - |
          objectName: ${var.sendgrid_apikey_secret}                
          objectType: secret
          objectVersion: ""
      
      EOT
        "tenantId"               = var.az_tenant_id
        "usePodIdentity"         = "false"
        "useVMManagedIdentity"   = "true"
        "userAssignedIdentityID" = data.azurerm_user_assigned_identity.azurekeyvaultsecretsprovider.client_id
      }
      "provider" = "azure"
      "secretObjects" = [
        {
          "data" = [
            {
              "key"        = "API_KEY"
              "objectName" = var.sendgrid_apikey_secret
            }
          ]
          "secretName" = var.sendgrid_apikey_secret
          "type"       = "Opaque"
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "secret_provider_class_ai_secret" {
  count = var.ai_manage ? 1 : 0
  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "${var.ai_secret}-spc"
      "namespace" = var.tenant
    }
    "spec" = {
      "parameters" = {
        "keyvaultName"           = local.keyvault_name
        "objects"                = <<-EOT
      array:
        - |
          objectName: ${var.azure_openai_endpoint_secret_name}                
          objectType: secret
          objectVersion: ""
        - |
          objectName: ${var.azure_openai_key_secret_name}              
          objectType: secret
          objectVersion: ""
        - |
          objectName: ${var.search_service_endpoint_secret_name}              
          objectType: secret
          objectVersion: ""
        - |
          objectName: ${var.search_service_key_secret_name}              
          objectType: secret
          objectVersion: ""
      
      EOT
        "tenantId"               = var.az_tenant_id
        "usePodIdentity"         = "false"
        "useVMManagedIdentity"   = "true"
        "userAssignedIdentityID" = data.azurerm_user_assigned_identity.azurekeyvaultsecretsprovider.client_id
      }
      "provider" = "azure"
      "secretObjects" = [
        {
          "data" = [
            {
              "key"        = "AZURE_ENDPOINT"
              "objectName" = var.azure_openai_endpoint_secret_name
            },
            {
              "key"        = "AZURE_OPENAI_API_KEY"
              "objectName" = var.azure_openai_key_secret_name
            },
            {
              "key"        = "AZURE_SEARCH_API_KEY"
              "objectName" = var.search_service_key_secret_name
            },
            {
              "key"        = "AZURE_SEARCH_SERVICE"
              "objectName" = var.search_service_endpoint_secret_name
            }
          ]
          "secretName" = var.ai_secret
          "type"       = "Opaque"
        },
      ]
    }
  }
}

resource "kubernetes_secret" "connection_string_secret" {
  count = var.tenant_manage_cosmosdb ? 1 : 0

  depends_on = [
    kubernetes_namespace.kub_tenant_namespace
  ]
  metadata {
    name      = var.database_secret_name_dim
    namespace = var.tenant
  }
  data = {
    primary_connection_string = "mongodb://${local.cosmosdb_account_name}:${data.azurerm_cosmosdb_account.cosmosdb_account.primary_key}@${local.cosmosdb_account_name}.mongo.cosmos.azure.com:10255?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${local.cosmosdb_account_name}@"
  }

  type = "kubernetes.io/generic"
}

resource "kubernetes_secret" "connection_string_topic_event" {
  count = var.tenant_manage_asb ? 1 : 0

  depends_on = [
    kubernetes_namespace.kub_tenant_namespace
  ]
  metadata {
    name      = var.topic_event_secret
    namespace = var.tenant
  }
  data = {
    primary_connection_string = data.azurerm_servicebus_topic_authorization_rule.topic_event[0].primary_connection_string
  }

  type = "kubernetes.io/generic"
}

resource "kubernetes_secret" "connection_string_topic_mgmt" {
  count = var.tenant_manage_asb ? 1 : 0

  depends_on = [
    kubernetes_namespace.kub_tenant_namespace
  ]
  metadata {
    name      = var.topic_mgmt_secret
    namespace = var.tenant
  }
  data = {
    primary_connection_string = data.azurerm_servicebus_topic_authorization_rule.topic_mgmt[0].primary_connection_string
  }

  type = "kubernetes.io/generic"
}
