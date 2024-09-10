variable "monitoring_storage_account_name" {}
variable "manage_monitoring" {
  default = true
  type    = bool
}
variable "monitoring_storage_replication_type" {
  default = "GZRS"
  type    = string
}
