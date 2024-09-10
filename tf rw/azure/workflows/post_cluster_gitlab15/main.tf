locals {
  aks_rg_name                 = "${var.env_prefix}-${var.gitlab_instance}-rg-aks-cluster"
  aks_nrg_name                = "${var.env_prefix}-${var.gitlab_instance}-rg-aks-cluster-resources"
  aks_name                    = "${var.env_prefix}-${var.gitlab_instance}-aks-cluster"
  user_assigned_identity_name = "azurekeyvaultsecretsprovider-${var.env_prefix}-${var.gitlab_instance}-aks-cluster"
  keyvault_name               = "${var.env_prefix}-keyvault"
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

resource "kubernetes_manifest" "secret_provider_class_cert_private" {
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
        "keyvaultName"           = local.keyvault_name
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
