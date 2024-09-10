data "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  resource_group_name = var.aks_rg_name
}

data "kubernetes_secret" "grafana_secret" {
  metadata {
    name      = "grafana"
    namespace = "ra-monitoring"
  }
  binary_data = {
    "admin-password" = ""
  }
}

resource "harness_platform_secret_text" "grafana_password_secret" {
  identifier                = var.grafana_secret_name
  name                      = var.grafana_secret_name
  value                     = base64decode(data.kubernetes_secret.grafana_secret.binary_data["admin-password"])
  value_type                = "Inline"
  secret_manager_identifier = var.harness_secret_manager_identifier
  depends_on                = [data.kubernetes_secret.grafana_secret]
}
