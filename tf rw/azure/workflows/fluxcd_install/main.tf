locals {
  aks_name                = "${var.env_prefix}-${var.env_name}-aks-cluster-${var.cluster_index}"
  aks_rg_name             = "${var.env_prefix}-${var.env_name}-rg-aks-cluster"
  aks_nrg_name            = "${var.env_prefix}-${var.env_name}-rg-aks-cluster-${var.cluster_index}-resources"
  keyvault_name           = "${var.env_prefix}-${var.env_name}-keyvault"
  keyvault_rg_name        = "${var.env_prefix}-${var.env_name}-rg-keyvault"
  fluxcd_identity_name    = "${var.env_prefix}-${var.env_name}-aks-cluster-${var.cluster_index}-fluxcd"
  fluxcd_fed_id_cred_name = "${var.env_prefix}-${var.env_name}-aks-cluster-${var.cluster_index}-fluxcd-fed-id"
  flux_git_path           = var.cluster_index == "247" ? format("clusters/%s", var.env_name) : format("clusters/%s-%03d", var.env_name, var.cluster_index)
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_rg_name
}

data "azurerm_key_vault" "akv" {
  name                = local.keyvault_name
  resource_group_name = local.keyvault_rg_name
}

// Create a User Assigned Identity (UAI) to be used by Flux Kustomize controller service account.
module "fluxcd_identity" {
  source                = "../../modules/managed_identity"
  rg_name               = local.aks_nrg_name
  location              = var.location
  managed_identity_name = local.fluxcd_identity_name
}

resource "azurerm_role_assignment" "managed_identity_reader" {
  scope                = data.azurerm_key_vault.akv.id
  role_definition_name = "Key Vault Crypto User"
  principal_id         = module.fluxcd_identity.principal_id
}

// Grant the User Assigned Identity access to the KeyVault.
// The Flux Kustomize controller will retrieve the private key to decrypt secrets.
module "keyvault_fluxcd_identity_access_policy" {
  source                      = "../../modules/keyvault_access_policy"
  keyvault_tenant_id          = data.azurerm_key_vault.akv.tenant_id
  keyvault_id                 = data.azurerm_key_vault.akv.id
  keyvault_object_id          = module.fluxcd_identity.principal_id
  keyvault_cert_permissions   = var.fluxcd_keyvault_cert_permissions
  keyvault_secret_permissions = var.fluxcd_keyvault_secret_permissions
  keyvault_key_permissions    = var.fluxcd_keyvault_key_permissions
}

// Create a trust relationship between the AKS cluster and the User Assigned Identity.
// A credential is issued to be used by the specified Kubernetes Service Account.
resource "azurerm_federated_identity_credential" "fluxcd_fed_id_cred" {
  name                = local.fluxcd_fed_id_cred_name
  resource_group_name = local.aks_nrg_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = data.azurerm_kubernetes_cluster.aks.oidc_issuer_url
  parent_id           = module.fluxcd_identity.id
  subject             = "system:serviceaccount:${var.flux_namespace}:kustomize-controller"
}

// Enable the managed AKS extension for FluxCD
module "aks_flux_ext" {
  source = "../../modules/aks_flux"

  aks_id                  = data.azurerm_kubernetes_cluster.aks.id
  aks_flux_extension_name = "${local.aks_name}-flux"
  aks_flux_config_name    = var.flux_namespace

  flux_git_url             = var.flux_git_url
  flux_git_https_key       = var.flux_git_https_key
  flux_git_reference_value = var.flux_git_reference_value
  flux_kustomizations = [
    {
      name = "cluster",
      path = local.flux_git_path
    }
  ]
}

# We don't have access to the Helm chart or the Flux Kustomization installed by the Flux extension. 
# Therefore, we must find a way to patch the kustomize-controller to enable workload identity.
# 
# Issues:
# - kubernetes_labels and kubernetes_annotations don't play nicely together: https://github.com/hashicorp/terraform-provider-kubernetes/issues/2285
# - Kubernetes provider does not have a patch feature: https://github.com/hashicorp/terraform-provider-kubernetes/issues/723
resource "kubectl_manifest" "patch_kustomize_sa" {
  yaml_body = <<YAML
apiVersion: v1
kind: ServiceAccount
metadata:
  name:  kustomize-controller
  namespace: ${var.flux_namespace}
  labels:
    "azure.workload.identity/use": "true"
  annotations:
    "azure.workload.identity/client-id": ${module.fluxcd_identity.client_id}
YAML
  depends_on = [
    module.aks_flux_ext,
    module.fluxcd_identity
  ]
}

# Enable workload identity in Kustomize-controller pods
# kubernetes_labels can't patch the labels of pods defined in a deployment: https://github.com/hashicorp/terraform-provider-kubernetes/issues/2310
resource "kubectl_manifest" "patch_kustomize_deploy" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name:  kustomize-controller
  namespace: ${var.flux_namespace}
spec:
  template:
    metadata:
      labels:
        "azure.workload.identity/use": "true"
YAML
  depends_on = [
    module.aks_flux_ext,
    kubectl_manifest.patch_kustomize_sa
  ]
}
