variable "global_vnet_address" {
  default = "10.245.0.0/16"
}
# variable "global_subnet_address_prefixes" {
#   default = "10.245.0.0/24"
# }
variable "service_endpoints" {
  type    = list(string)
  default = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry", "Microsoft.AzureCosmosDB", "Microsoft.Web"]
}
