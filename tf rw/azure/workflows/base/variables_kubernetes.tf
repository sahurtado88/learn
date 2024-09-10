variable "subscription_id_tenant" {}

variable "base_infra_namespace_with_istio_inject" {
  type    = list(string)
  default = ["ra-system", "ra-monitoring"]
}

variable "base_infra_namespace_without_istio_inject" {
  type    = list(string)
  default = ["istio-system", "cert-manager", "kyverno"]
}

# names of the acr-related secrets in harness
variable "acr_username" {
  type = string
}

variable "acr_password" {
  type = string
}

variable "acr_server" {
  type = string
}

variable "docker_container_secret_name" {
  default = "ra-creg"
}
variable "docker_container_secret_namespace" {
  default = "ra-system"
}

variable "user_operator_manage" {
  default = true
  type    = bool
}

variable "user_operator_workload_identity_name" {
  default = "user_operator_workload_identity"
  type    = string
}