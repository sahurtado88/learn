data "azurerm_subscription" "current" {}
data "azurerm_policy_definition" "container_registry_policy" {
  name = var.container_registry_policy_definition
}

resource "azurerm_subscription_policy_assignment" "allowed_container_registries" {
  name                 = var.container_registry_policy_assignment
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = data.azurerm_policy_definition.container_registry_policy.id
  parameters           = <<PARAMS
  {
    "excludedNamespaces": {
      "value": ${jsonencode(var.list_excluded_namespaces)}
    },
    "effect": {
      "value": "Deny"
    },
    "allowedContainerImagesRegex": {
      "value": "^([^\/]+\\.(${join("|", [for reg in var.list_registries : reg])})\\.io)\\/.+$"
    }
  }
  PARAMS
}
