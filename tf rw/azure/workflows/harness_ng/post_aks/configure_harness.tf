locals {
  aks_client_certificate_name     = var.harness_aks_client_certificate_name
  aks_host_name                   = var.harness_aks_host_name
  aks_client_key_name             = var.harness_aks_client_key_name
  aks_cluster_ca_certificate_name = var.harness_aks_cluster_ca_certificate_name
  aks_username                    = var.harness_aks_username
  aks_password                    = var.harness_aks_password
  aks_k8s_cloud_provider          = var.harness_aks_k8s_cloud_provider
  sa_token_secret_name            = var.harness_sa_token_secret_name
  sa_ca_cert_secret_name          = var.harness_sa_ca_cert_secret_name
}

data "harness_platform_project" "app" {
  org_id = var.harness_org_id
  name   = var.harness_app
}

data "harness_platform_environment" "env" {
  org_id     = var.harness_org_id
  project_id = data.harness_platform_project.app.id
  identifier = var.harness_env_id
  name       = var.harness_env
}

resource "harness_platform_secret_text" "aks_client_certificate" {
  identifier                = local.aks_client_certificate_name
  name                      = local.aks_client_certificate_name
  value                     = data.azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  value_type                = "Inline"
  secret_manager_identifier = var.harness_secret_manager_identifier
}

resource "harness_platform_secret_text" "aks_host" {
  identifier                = local.aks_host_name
  name                      = local.aks_host_name
  value                     = data.azurerm_kubernetes_cluster.aks.kube_config[0].host
  value_type                = "Inline"
  secret_manager_identifier = var.harness_secret_manager_identifier
}

resource "harness_platform_secret_text" "aks_client_key" {
  identifier                = local.aks_client_key_name
  name                      = local.aks_client_key_name
  value                     = data.azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  value_type                = "Inline"
  secret_manager_identifier = var.harness_secret_manager_identifier
}

resource "harness_platform_secret_text" "aks_cluster_ca_certificate" {
  identifier                = local.aks_cluster_ca_certificate_name
  name                      = local.aks_cluster_ca_certificate_name
  value                     = data.azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  value_type                = "Inline"
  secret_manager_identifier = var.harness_secret_manager_identifier
}

resource "harness_platform_secret_text" "aks_username" {
  identifier                = local.aks_username
  name                      = local.aks_username
  value                     = data.azurerm_kubernetes_cluster.aks.kube_config[0].username
  value_type                = "Inline"
  secret_manager_identifier = var.harness_secret_manager_identifier
}

resource "harness_platform_secret_text" "aks_password" {
  identifier                = local.aks_password
  name                      = local.aks_password
  value                     = data.azurerm_kubernetes_cluster.aks.kube_config[0].password
  value_type                = "Inline"
  secret_manager_identifier = var.harness_secret_manager_identifier
}

resource "harness_platform_secret_text" "sa_token" {
  identifier                = local.sa_token_secret_name
  name                      = local.sa_token_secret_name
  value                     = kubernetes_secret.harness_sa_secret.data["token"]
  value_type                = "Inline"
  secret_manager_identifier = var.harness_secret_manager_identifier

  depends_on = [
    kubernetes_secret.harness_sa_secret
  ]
}

resource "harness_platform_secret_text" "sa_ca_cert" {
  identifier                = local.sa_ca_cert_secret_name
  name                      = local.sa_ca_cert_secret_name
  value                     = kubernetes_secret.harness_sa_secret.data["ca.crt"]
  value_type                = "Inline"
  secret_manager_identifier = var.harness_secret_manager_identifier

  depends_on = [
    kubernetes_secret.harness_sa_secret
  ]
}

resource "harness_platform_connector_kubernetes" "aks_k8s_cloud_provider" {
  identifier = local.aks_k8s_cloud_provider
  name       = local.aks_k8s_cloud_provider

  service_account {
    master_url                = data.azurerm_kubernetes_cluster.aks.kube_config[0].host
    service_account_token_ref = "account.${harness_platform_secret_text.sa_token.id}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "harness_platform_infrastructure" "harness_k8s" {
  identifier      = var.harness_infra_def_name_kub_deploy
  name            = var.harness_infra_def_name_kub_deploy
  org_id          = var.harness_org_id
  project_id      = data.harness_platform_project.app.id
  env_id          = data.harness_platform_environment.env.id
  type            = "KubernetesDirect"
  deployment_type = "Kubernetes"
  yaml            = <<-EOT
      infrastructureDefinition:
        name: ${var.harness_infra_def_name_kub_deploy}
        identifier: ${var.harness_infra_def_name_kub_deploy}
        description: ""
        orgIdentifier: ${var.harness_org_id}
        projectIdentifier: ${data.harness_platform_project.app.id}
        environmentRef: ${data.harness_platform_environment.env.id}
        deploymentType: Kubernetes
        type: KubernetesDirect
        spec:
          connectorRef: account.${harness_platform_connector_kubernetes.aks_k8s_cloud_provider.identifier}
          namespace: <+stage.variables.namespace>
          releaseName: <+stage.variables.releasename>
        allowSimultaneousDeployments: true
    EOT

  depends_on = [
    harness_platform_connector_kubernetes.aks_k8s_cloud_provider
  ]
}

resource "harness_platform_infrastructure" "harness_k8s_native_helm" {
  identifier      = var.harness_infra_def_name_native_helm
  name            = var.harness_infra_def_name_native_helm
  org_id          = var.harness_org_id
  project_id      = data.harness_platform_project.app.id
  env_id          = data.harness_platform_environment.env.id
  type            = "KubernetesDirect"
  deployment_type = "NativeHelm"
  yaml            = <<-EOT
      infrastructureDefinition:
        name: ${var.harness_infra_def_name_native_helm}
        identifier: ${var.harness_infra_def_name_native_helm}
        orgIdentifier: ${var.harness_org_id}
        projectIdentifier: ${data.harness_platform_project.app.id}
        environmentRef: ${data.harness_platform_environment.env.id}
        deploymentType: NativeHelm
        type: KubernetesDirect
        spec:
          connectorRef: account.${harness_platform_connector_kubernetes.aks_k8s_cloud_provider.identifier}
          namespace: <+stage.variables.namespace>
          releaseName: <+service.name>-<+env.name>
        allowSimultaneousDeployments: true
    EOT
}
