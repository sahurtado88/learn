# data "azurerm_policy_definition" "allowed_ports_policy" {
#   name = var.allowed_ports_policy_definition
# }

# resource "azurerm_resource_group_policy_assignment" "allowed-serice-ports" {
#   name                 = "${var.allowed_ports_policy_assignment}-${module.aks_cluster_rg.name}"
#   resource_group_id    = module.aks_cluster_rg.id
#   policy_definition_id = data.azurerm_policy_definition.allowed_ports_policy.id
#   parameters           = <<PARAMS
#   {
#     "excludedNamespaces": {
#       "value": ${jsonencode(var.list_excluded_namespaces_ports)}
#     },
#     "effect": {
#       "value": "Deny"
#     },
#     "allowedServicePortsList": {
#       "value": ${jsonencode(var.list_allowed_ports)}
#     }
#   }
#   PARAMS
# }