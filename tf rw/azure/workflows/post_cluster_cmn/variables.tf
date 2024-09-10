variable "az_tenant_id" {}
variable "dns_name_prefix" {}
variable "env_name" {}
variable "env_prefix" {
  default = "ftds"
}
variable "cmn_namespace_with_spc" {
  type    = list(string)
  default = ["ra-system", "ra-common", "ra-monitoring", "gitlab"]
}

variable "fthub-client-id" {
  default = "fthub-client-id"
}
variable "fthub-client-secret" {
  default = "fthub-client-secret"
}
variable "fthub-auth0-token-secret" {
  default = "fthub-auth0-token"
}
variable "deployment_function_endpoint" {
  default = "deployment-function-endpoint"
}
variable "deployment_function_api_key" {
  default = "deployment-function-api-key"
}
variable "ftvault-client-id" {
  default = "ftvault-client-id"
}
variable "ftvault-client-secret" {
  default = "ftvault-client-secret"
}
variable "ftvault-auth0-token-secret" {
  default = "ftvault-auth0-token"
}
variable "ftra-client-id" {
  default = "ftra-client-id"
}
variable "ftra-client-secret" {
  default = "ftra-client-secret"
}
variable "ftra-auth0-token-secret" {
  default = "ftra-auth0-token"
}

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