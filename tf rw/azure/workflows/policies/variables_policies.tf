variable "container_registry_policy_assignment" {
  default = "container_registry_policy"
}

variable "container_registry_policy_definition" {
  default     = "febd0533-8e55-448f-b837-bd0e06f16469"
  description = "Azure Built-In Policy Definition: Kubernetes cluster containers should only use allowed images"
}

variable "list_excluded_namespaces" {
  type        = list(string)
  description = "List of namespaces excluded from the container registry policy"
  default = [
    "kube-system",
    "gatekeeper-system",
    "azure-arc",
    "cert-manager",
    "istio-system",
    "gitlab",
    "ra-monitoring",
    "harness-system",
    "flux-system"
  ]
}

variable "list_registries" {
  type        = list(string)
  description = "list of container registry domains to allow (syntax: subdomain.{var.list_registries[x]}.io/.+)"
  default     = ["azurecr"]
}
