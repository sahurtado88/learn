# variable "allowed_ports_policy_assignment" {
#   default = "allowed-ports-policy"
# }

# variable "allowed_ports_policy_definition" {
#   default     = "233a2a17-77ca-4fb1-9b6b-69223d272a44"
#   description = "Azure Built-In Policy Definition: Kubernetes cluster services should listen only on allowed ports"
# }

# variable "list_excluded_namespaces_ports" {
#   type        = list(string)
#   description = "List of namespaces excluded from the allowed ports policy"
#   default = [
#     "kube-system",
#     "gatekeeper-system",
#     "azure-arc",
#     "cert-manager",
#     "gitlab",
#     "harness-system",
#     "ra-monitoring"
#   ]
# }

# variable "list_allowed_ports" {
#   type        = list(string)
#   description = "list of ports allowed to be exposed for containers"
#   default = [
#     "80",    # istio ingress gtwy and others
#     "443",   # istio ingress gtwy and others
#     "8443",  # istio private gtwy, tenant/user operators
#     "4202",  # webapp
#     "15021", # istio ingress gtwy
#     "25103", # system manager
#     "25102", # audit logging
#     "7773",  # developer logging
#     "9100",  # policy director
#     "9102",  # policy agent
#     "10000", # workspace user
#     "4204",  # portal
#     "3100",  # loki
#     "8080",  # prometheus-metrics
#     "9091",  # prometheus-pushgateway
#     "9402",  # certmanager
#     "15010", # istiod
#     "15012", # istiod
#     "15014", # istiod
#     "8898",  # bridge
#     "3100",  # loki
#   ]
# }
