variable "datastore_type" {
  default = "VaultStore"
}
variable "redundancy" {
  default = "GeoRedundant"
}
variable "tfstate_backup_manage" {
  default = true
}
variable "retention_duration" {
  default = "P365D"
}