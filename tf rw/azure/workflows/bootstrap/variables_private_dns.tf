variable "private_dns_name" {
  default = "ftds-private.rockwellautomation.com"
  type    = string
}

variable "sa_blob_private_dns_name" {
  default = "privatelink.blob.core.windows.net"
}
variable "sa_file_private_dns_name" {
  default = "privatelink.file.core.windows.net"
}

variable "sa_queue_private_dns_name" {
  default = "privatelink.queue.core.windows.net"
}
variable "acr_private_dns_name" {
  default = "privatelink.azurecr.io"
}

variable "kv_private_dns_name" {
  default = "privatelink.vaultcore.azure.net"
}
variable "azurewebsites_private_dns_name" {
  default = "privatelink.azurewebsites.net"
}
variable "cosmosdb_private_dns_name" {
  default = "privatelink.mongo.cosmos.azure.com"
}
