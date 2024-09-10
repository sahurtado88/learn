variable "private_dns_name" {
  default = "ftds-private.rockwellautomation.com"
  type    = string
}

variable "sa_blob_private_dns_name" {
  default = "privatelink.blob.core.windows.net"
}
variable "postgres_private_dns_name" {
  default = "privatelink.postgres.database.azure.com"
}

variable "azure_subscription_id_internal" {}

variable "azuredns_client_id" {}

variable "azuredns_client_secret" {}
