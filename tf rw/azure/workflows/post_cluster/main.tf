locals {
  aks_rg_name                 = "${var.env_prefix}-${var.env_name}-rg-aks-cluster"
  aks_nrg_name                = "${var.env_prefix}-${var.env_name}-rg-aks-cluster-%03d-resources"
  aks_name                    = "${var.env_prefix}-${var.env_name}-aks-cluster-${var.cluster_index}"
  user_assigned_identity_name = "azurekeyvaultsecretsprovider-${var.env_prefix}-${var.env_name}-aks-cluster-${var.cluster_index}"
  keyvault_name               = "${var.env_prefix}-${var.env_name}-keyvault"
  global_keyvault_name        = "${var.env_prefix}-keyvault"
  rg_general                  = "${var.env_prefix}-${var.env_name}-rg-general"
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_rg_name
}

data "azurerm_user_assigned_identity" "azurekeyvaultsecretsprovider" {
  name                = local.user_assigned_identity_name
  resource_group_name = format(local.aks_nrg_name, var.cluster_index)
}

data "azurerm_storage_account" "monitoring_storage_account" {
  name                = var.monitoring_storage_account_name
  resource_group_name = local.rg_general
}

resource "kubernetes_manifest" "secret_provider_class_cert" {
  count = length(var.base_infra_namespace_with_istio_inject)

  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "${var.base_infra_namespace_with_istio_inject[count.index]}-akv-spc"
      "namespace" = var.base_infra_namespace_with_istio_inject[count.index]
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

resource "kubernetes_manifest" "secret_provider_class_cert_private_global" {
  count = length(var.base_infra_namespace_with_istio_inject)
  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "ftds-private-cert-akv-spc"
      "namespace" = var.base_infra_namespace_with_istio_inject[count.index]
    }
    "spec" = {
      "parameters" = {
        "keyvaultName"           = local.global_keyvault_name
        "objects"                = <<-EOT
      array:
        - |
          objectName: ftds-private-cert
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
              "objectName" = "ftds-private-cert"
            },
            {
              "key"        = "tls.crt"
              "objectName" = "ftds-private-cert"
            },
          ]
          "secretName" = "ftds-private"
          "type"       = "kubernetes.io/tls"
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "secret_provider_class_global_storage" {

  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "${var.global_sa_constr_secret}-akv-spc"
      "namespace" = "ra-system"
    }
    "spec" = {
      "parameters" = {
        "keyvaultName"           = local.global_keyvault_name
        "objects"                = <<-EOT
      array:
        - |
          objectName: ${var.global_sa_constr_secret}                
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
              "key"        = var.global_sa_constr_secret
              "objectName" = var.global_sa_constr_secret
            }
          ]
          "secretName" = var.global_sa_constr_secret
          "type"       = "Opaque"
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "secret_provider_class_ftvault_auth0_token" {

  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "${var.ftvault-auth0-token-secret}-akv-spc"
      "namespace" = "ra-system"
    }
    "spec" = {
      "parameters" = {
        "keyvaultName"           = local.keyvault_name
        "objects"                = <<-EOT
      array:
        - |
          objectName: ${var.ftvault-auth0-token-secret}                
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
              "key"        = var.ftvault-auth0-token-secret
              "objectName" = var.ftvault-auth0-token-secret
            }
          ]
          "secretName" = var.ftvault-auth0-token-secret
          "type"       = "Opaque"
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "secret_provider_class_cosmosdb" {

  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "cosmosdb-akv-spc"
      "namespace" = "ra-system"
    }
    "spec" = {
      "parameters" = {
        "keyvaultName"           = local.keyvault_name
        "objects"                = <<-EOT
      array:
        - |
          objectName: ${var.cosmosdb_primary_readonly_connection_string}
          objectType: secret
          objectVersion: ""
        - |
          objectName: ${var.cosmosdb_secondary_readonly_connection_string}
          objectType: secret
          objectVersion: ""
        - |
          objectName: ${var.cosmosdb_primary_readwrite_connection_string}
          objectType: secret
          objectVersion: ""
        - |
          objectName: ${var.cosmosdb_secondary_readwrite_connection_string}
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
              "key"        = var.cosmosdb_primary_readonly_connection_string
              "objectName" = var.cosmosdb_primary_readonly_connection_string
            },
            {
              "key"        = var.cosmosdb_secondary_readonly_connection_string
              "objectName" = var.cosmosdb_secondary_readonly_connection_string
            },
            {
              "key"        = var.cosmosdb_primary_readwrite_connection_string
              "objectName" = var.cosmosdb_primary_readwrite_connection_string
            },
            {
              "key"        = var.cosmosdb_secondary_readwrite_connection_string
              "objectName" = var.cosmosdb_secondary_readwrite_connection_string
            }
          ]
          "secretName" = var.cosmosdb-secret
          "type"       = "Opaque"
        },
      ]
    }
  }
}
