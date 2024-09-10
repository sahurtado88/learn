variable "base_infra_namespace_with_istio_inject" {
  type    = list(string)
  default = ["ra-system", "ra-common", "ra-monitoring"]
}

variable "base_infra_namespace_without_istio_inject" {
  type    = list(string)
  default = ["istio-system", "cert-manager", "gitlab", "kyverno"]
}

# variable "gitlab_pg_admin_username" {
#   default = "localadmin"
# }

# variable "gitlab_sc_sku" {
#   default = "GZRS"
# }

# variable "gitlab_root_password" {
#   default = ""
#   type    = string
# }

variable "azure_client_secret" {}
variable "azure_swc_client_secret" {}

variable "database_secret_name_catalog" {
  default = "catalog-database"
}
variable "database_secret_namespace_catalog" {
  default = "ra-common"
}

variable "cosmosdb_database_name_catalog" {
  default = "catalog"
}

variable "database_secret_name_cosmosdb_rw" {
  default = "cosmosdb-access-rw"
}

variable "database_secret_name_cosmosdb_ro" {
  default = "cosmosdb-access-ro"
}
variable "database_secret_namespace_cosmosdb" {
  default = "ra-common"
}

variable "manage_cosmosdb" {
  default = true
}

