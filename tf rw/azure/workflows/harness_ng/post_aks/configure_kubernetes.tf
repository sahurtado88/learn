locals {
  service_account_name                      = "harness"
  service_account_namespace                 = "harness-system"
  service_account_cluster_role_binding_name = "harness-crb"
}

resource "kubernetes_namespace" "harness_system" {
  metadata {
    labels = {
      app = local.service_account_namespace
    }

    name = local.service_account_namespace
  }
}

resource "kubernetes_service_account" "harness_sa" {
  metadata {
    name      = local.service_account_name
    namespace = local.service_account_namespace
  }
  # We need namespace to be created before we can create service account
  # for it. Kubernetes namespace resource does not output name which is
  # required for service account setup, so we need this depends on.
  depends_on = [kubernetes_namespace.harness_system]
}

resource "kubernetes_cluster_role_binding" "harness_crb" {
  metadata {
    name = local.service_account_cluster_role_binding_name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = local.service_account_name
    namespace = local.service_account_namespace
  }
  depends_on = [kubernetes_service_account.harness_sa]
}

resource "kubernetes_secret" "harness_sa_secret" {
  metadata {
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.harness_sa.metadata[0].name
    }
    namespace     = local.service_account_namespace
    generate_name = "${kubernetes_service_account.harness_sa.metadata[0].name}-token-"
  }
  type                           = "kubernetes.io/service-account-token"
  wait_for_service_account_token = true
}
