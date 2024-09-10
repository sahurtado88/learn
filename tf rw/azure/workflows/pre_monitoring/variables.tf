variable "env_prefix" {}
variable "env_name" {}

variable "aks_name" {}
variable "aks_rg_name" {}
variable "cluster_index" {}

variable "monitoring_storage_account_name" {}

variable "monitoring_secret_namespace" {
  default = "ra-monitoring"
}

variable "monitoring_secret_name" {
  default = "blob-storage"
}
