variable "monitoring_storage_account_name" {}
variable "container_auth" {
  default = "auth"
}
variable "common_storage_replication_type" {
  default = "GZRS"
  type    = string
}