variable "private_dns_name" {
  default = "ftds-private.rockwellautomation.com"
  type    = string
}
variable "kv_private_dns_name" {
  default = "privatelink.vaultcore.azure.net"
}
variable "sa_queue_private_dns_name" {
  default = "privatelink.queue.core.windows.net"
}
variable "acr_private_dns_name" {
  default = "privatelink.azurecr.io"
}
variable "sa_blob_private_dns_name" {
  default = "privatelink.blob.core.windows.net"
}
variable "sa_file_private_dns_name" {
  default = "privatelink.file.core.windows.net"
}

variable "mongo_cosmos_private_dns_name" {
  default = "privatelink.mongo.cosmos.azure.com"
}
# variable "azure_api_private_dns_name" {
#   default = "privatelink.azure-api.net"
# }
variable "azurewebsites_private_dns_name" {
  default = "privatelink.azurewebsites.net"
}
