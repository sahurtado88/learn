variable "azurerm_subnet_address_prefixes" {
  default = "10.245.65.0/25"
}
variable "monitoring_storage_replication_type" {
  default = "GZRS"
}
variable "sa_functions_pep_manual_conn" {
  default = false
}
variable "sa_subresource_names" {
  default = ["blob"]
}
variable "functions_pep_manual_conn" {
  default = false
}
variable "functions_subresource_names" {
  default = ["sites"]
}

variable "cosmosdb_pep_manual_conn" {
  default = false
}
variable "cosmosdb_subresource_names" {
  default = ["MongoDB"]
}

# variable "api_management_pep_manual_conn" {
#   default = false
# }
# variable "api_management_subresource_names" {
#   default = ["Gateway"]
# }
