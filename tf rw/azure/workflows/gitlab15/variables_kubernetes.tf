variable "base_infra_namespace_with_istio_inject" {
  type    = list(string)
  default = ["ra-system", "ra-common", "ra-monitoring"]
}

variable "base_infra_namespace_without_istio_inject" {
  type    = list(string)
  default = ["istio-system", "cert-manager", "gitlab"]
}
variable "gitlab_pg_admin_username" {
  default = "localadmin"
}

# variable "gitlab_sc_sku" {
#   default = "GZRS"
# }

variable "gitlab_root_password" {
  default = ""
  type    = string
}

variable "azure_client_secret" {}
variable "azure_swc_client_secret" {}
