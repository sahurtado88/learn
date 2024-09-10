locals {
  user_operator_service_account_name = "user-operator-controller-manager-workload-identity"
  user_operator_fed_id_cred_name     = "user_operator_fed_id_cred_cluster_${var.cluster_index}"
}

module "user_operator_workload_identity" {
  count                 = var.user_operator_manage ? 1 : 0
  source                = "../../modules/managed_identity"
  rg_name               = format(local.aks_nrg_name, var.cluster_index)
  location              = var.location
  managed_identity_name = var.user_operator_workload_identity_name
  depends_on = [
    data.azurerm_resource_group.aks_cluster_rg
  ]
}

resource "azurerm_role_assignment" "storage_contributor" {
  scope                = "/subscriptions/${var.subscription_id_tenant}/resourceGroups/${local.rg_tenant}"
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.user_operator_workload_identity[0].principal_id
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


# secret for connecting to registry to pull for new slim system manager
resource "kubernetes_secret" "docker_container_secret" {
  metadata {
    name      = var.docker_container_secret_name
    namespace = var.docker_container_secret_namespace
  }
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        (var.acr_server) = {
          "username" = var.acr_username
          "password" = var.acr_password
          "auth"     = base64encode("${var.acr_username}:${var.acr_password}")
        }
      }
    })
  }

  type       = "kubernetes.io/dockerconfigjson"
  depends_on = [module.aks]
}

resource "kubernetes_service_account" "user_operator_sa" {
  metadata {
    name      = local.user_operator_service_account_name
    namespace = var.base_infra_namespace_with_istio_inject[0]
    labels = {
      "azure.workload.identity/use" = true
    }
    annotations = {
      "azure.workload.identity/client-id" = module.user_operator_workload_identity[0].client_id
    }
  }
}

resource "azurerm_federated_identity_credential" "user_operator_fed_id_cred" {
  name                = local.user_operator_fed_id_cred_name
  resource_group_name = format(local.aks_nrg_name, var.cluster_index)
  audience            = ["api://AzureADTokenExchange"]
  issuer              = module.aks.aks_oidc_issuer_url
  parent_id           = module.user_operator_workload_identity[0].id
  subject             = "system:serviceaccount:${var.base_infra_namespace_with_istio_inject[0]}:${local.user_operator_service_account_name}"
}
