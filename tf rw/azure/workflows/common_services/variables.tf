variable "az_tenant_id" {}
variable "dns_name_prefix" {}
# variable "common_storage_replication_type" {
#   default = "GZRS"
#   type    = string
# }

# variable "boot_pep_vnet_name" {
# }

variable "env_name" {}

variable "env_prefix" {
  default = "ftds"
}
variable "acr_name" {}
variable "env_index" {
  default = 0
}
variable "env_max_clusters" {
  default = 20
}

# security context

variable "storage_account_manage_selected_networks" {
  default = true
}
variable "storage_account_manage_pep" {
  default = true
}

variable "delegation_manage" {
  default = false
}

variable "delegation_service_workload_identity_name" {
  default = "delegation_service_workload_identity"
}

variable "alerts_manage" {}
