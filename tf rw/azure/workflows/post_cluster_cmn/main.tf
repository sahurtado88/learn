locals {
  aks_rg_name                 = "${var.env_prefix}-${var.env_name}-rg-aks-cluster"
  aks_nrg_name                = "${var.env_prefix}-${var.env_name}-rg-aks-cluster-000-resources"
  aks_name                    = "${var.env_prefix}-${var.env_name}-aks-cluster-000"
  user_assigned_identity_name = "azurekeyvaultsecretsprovider-${var.env_prefix}-${var.env_name}-aks-cluster-000"
  keyvault_name               = "${var.env_prefix}-${var.env_name}-keyvault"
  global_keyvault_name        = "${var.env_prefix}-keyvault"
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_rg_name
}

data "azurerm_user_assigned_identity" "azurekeyvaultsecretsprovider" {
  name                = local.user_assigned_identity_name
  resource_group_name = local.aks_nrg_name
}

resource "kubernetes_manifest" "secret_provider_class_cert" {
  count = length(var.cmn_namespace_with_spc)

  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "${var.cmn_namespace_with_spc[count.index]}-akv-spc"
      "namespace" = var.cmn_namespace_with_spc[count.index]
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
  count = length(var.cmn_namespace_with_spc)
  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "ftds-private-cert-akv-spc"
      "namespace" = var.cmn_namespace_with_spc[count.index]
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

resource "kubernetes_manifest" "secret_provider_class_auth0_token" {

  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "${var.fthub-auth0-token-secret}-akv-spc"
      "namespace" = "ra-system"
    }
    "spec" = {
      "parameters" = {
        "keyvaultName"           = local.keyvault_name
        "objects"                = <<-EOT
      array:
        - |
          objectName: ${var.fthub-auth0-token-secret}                
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
              "key"        = var.fthub-auth0-token-secret
              "objectName" = var.fthub-auth0-token-secret
            }
          ]
          "secretName" = var.fthub-auth0-token-secret
          "type"       = "Opaque"
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "secret_provider_class_auth0_token_cmn" {

  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "${var.fthub-auth0-token-secret}-akv-spc"
      "namespace" = "ra-common"
    }
    "spec" = {
      "parameters" = {
        "keyvaultName"           = local.keyvault_name
        "objects"                = <<-EOT
      array:
        - |
          objectName: ${var.fthub-auth0-token-secret}                
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
              "key"        = var.fthub-auth0-token-secret
              "objectName" = var.fthub-auth0-token-secret
            }
          ]
          "secretName" = var.fthub-auth0-token-secret
          "type"       = "Opaque"
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "secret_provider_class_auth0_deployment_function" {

  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "deployment-function-akv-spc"
      "namespace" = "ra-common"
    }
    "spec" = {
      "parameters" = {
        "keyvaultName"           = local.keyvault_name
        "objects"                = <<-EOT
      array:
        - |
          objectName: ${var.deployment_function_endpoint}                
          objectType: secret
          objectVersion: ""
        - |
          objectName: ${var.deployment_function_api_key}                
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
              "key"        = var.deployment_function_endpoint
              "objectName" = var.deployment_function_endpoint
            },
            {
              "key"        = var.deployment_function_api_key
              "objectName" = var.deployment_function_api_key
            }
          ]
          "secretName" = "deployment-function"
          "type"       = "Opaque"
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "secret_provider_class_fthub_client" {

  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "fthub-client-akv-spc"
      "namespace" = "ra-system"
    }
    "spec" = {
      "parameters" = {
        "keyvaultName"           = local.keyvault_name
        "objects"                = <<-EOT
      array:
        - |
          objectName: "${var.fthub-client-id}"               
          objectType: secret
          objectVersion: ""
        - |
          objectName: "${var.fthub-client-secret}"           
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
              "key"        = var.fthub-client-id
              "objectName" = var.fthub-client-id
            },
            {
              "key"        = var.fthub-client-secret
              "objectName" = var.fthub-client-secret
            }
          ]
          "secretName" = "fthub-client"
          "type"       = "Opaque"
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "secret_provider_class_ftvault_client" {

  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "ftvault-client-akv-spc"
      "namespace" = "ra-system"
    }
    "spec" = {
      "parameters" = {
        "keyvaultName"           = local.keyvault_name
        "objects"                = <<-EOT
      array:
        - |
          objectName: "${var.ftvault-client-id}"               
          objectType: secret
          objectVersion: ""
        - |
          objectName: "${var.ftvault-client-secret}"           
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
              "key"        = var.ftvault-client-id
              "objectName" = var.ftvault-client-id
            },
            {
              "key"        = var.ftvault-client-secret
              "objectName" = var.ftvault-client-secret
            }
          ]
          "secretName" = "ftvault-client"
          "type"       = "Opaque"
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "secret_provider_class_ftra_client" {

  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "ftra-client-akv-spc"
      "namespace" = "ra-system"
    }
    "spec" = {
      "parameters" = {
        "keyvaultName"           = local.keyvault_name
        "objects"                = <<-EOT
      array:
        - |
          objectName: "${var.ftra-client-id}"               
          objectType: secret
          objectVersion: ""
        - |
          objectName: "${var.ftra-client-secret}"           
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
              "key"        = var.ftra-client-id
              "objectName" = var.ftra-client-id
            },
            {
              "key"        = var.ftra-client-secret
              "objectName" = var.ftra-client-secret
            }
          ]
          "secretName" = "ftra-client"
          "type"       = "Opaque"
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
      "namespace" = "ra-system"
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
