variable "search_service_sku" {
  default = "standard"
}

variable "search_service_partition_count" {
  default = 1
}

variable "search_service_replica_count" {
  default = 1
}

variable "search_service_local_authentication_enabled" {
  default = true
}

variable "search_service_public_network_access_enabled" {
  default = false
}