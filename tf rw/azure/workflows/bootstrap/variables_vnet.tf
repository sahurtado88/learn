variable "env_index" {
  default = 0
}
variable "env_max_clusters" {
  default = 20
}
variable "service_endpoints" {
  default = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
}
