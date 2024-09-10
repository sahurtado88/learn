variable "env_prefix" {}

variable "manage_cosmosdb" {
  default = true
}

variable "cosmosdb_throughput_authz" {
  default = 3000
}

variable "cosmosdb_throughput_dim" {
  default = 3000
}