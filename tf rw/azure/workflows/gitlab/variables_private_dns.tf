variable "private_dns_name" {
  default = "ftds-private.rockwellautomation.com"
  type    = string
}

variable "sa_blob_private_dns_name" {
  default = "privatelink.blob.core.windows.net"
}
variable "sa_queue_private_dns_name" {
  default = "privatelink.queue.core.windows.net"
}
variable "redis_private_dns_name" {
  default = "privatelink.redis.cache.windows.net"
}

variable "postgres_private_dns_name" {
  default = "privatelink.postgres.database.azure.com"
}

variable "azure_subscription_id_internal" {}

variable "azuredns_client_id" {}

variable "azuredns_client_secret" {}
