variable "az_tenant_id" {}
variable "dns_name_prefix" {}
variable "env_name" {}
variable "env_prefix" {
  default = "ftds"
}
variable "cluster_index" {
  default = "000"
}
variable "base_infra_namespace_with_istio_inject" {
  type    = list(string)
  default = ["ra-system", "ra-monitoring"]
}

variable "global_sa_constr_secret" {
  default = "global-sa-constr-secret"
  type    = string
}
variable "ftvault-auth0-token-secret" {
  default = "ftvault-auth0-token"
}

# variable "cosmosdb_manage" {
#   type    = bool
#   default = false
# }

variable "cosmosdb-secret" {
  default = "cosmosdb-secret"
  type    = string
}

variable "cosmosdb_primary_readonly_connection_string" {
  default = "cosmosdb-primary-readonly-connection-string"
  type    = string
}

variable "cosmosdb_secondary_readonly_connection_string" {
  default = "cosmosdb-secondary-readonly-connection-string"
  type    = string
}

variable "cosmosdb_primary_readwrite_connection_string" {
  default = "cosmosdb-primary-readwrite-connection-string"
  type    = string
}

variable "cosmosdb_secondary_readwrite_connection_string" {
  default = "cosmosdb-secondary-readwrite-connection-string"
  type    = string
}