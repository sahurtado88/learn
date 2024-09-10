# variable "common_vnet_address_space" {
#   default = "10.0.0.0/8"
#   type    = string
# }
variable "gitlab_storage_account_name" {}

variable "az_tenant_id" {}
variable "dns_name_prefix" {}
variable "global_storage_replication_type" {
  default = "GZRS"
  type    = string
}

# variable "boot_pep_vnet_name" {
# }

variable "env_name" {}

variable "gitlab_instance" {}

variable "gitlab_network_block" {}

variable "env_prefix" {
  default = "ftds"
}
variable "acr_name" {}

# security context

variable "storage_account_manage_selected_networks" {
  default = true
}
variable "storage_account_manage_pep" {
  default = true
}

variable "alerts_manage" {}
