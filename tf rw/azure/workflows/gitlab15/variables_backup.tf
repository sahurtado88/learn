variable "datastore_type" {
  default = "VaultStore"
}
variable "redundancy" {
  default = "GeoRedundant"
}
variable "backup_manage" {
  default = true
}
variable "retention_duration" {
  default = "P30D"
}