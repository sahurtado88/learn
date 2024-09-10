variable "tenant_storage_replication_type" {
  default = "GZRS"
  type    = string
}

variable "location" {
  description = "Azure location"
}

variable "tenant" {
  description = "Required for creating tenant. At this time it is going to be an guid provided by FTHub"
}

variable "az_tenant_id" {
  description = ""
}
variable "dns_name_prefix" {
  description = ""
}
variable "tenant_storage_account_network_access" {
  default = "Deny"
}
# variable "tenant_manage_selected_networks" {
#   default = false
# }

variable "azuredns_client_id" {}
variable "azuredns_client_secret" {}

variable "env_name" {}

variable "env_prefix" {
  default = "ftds"
}
variable "cluster_index" {
  default = "000"
}

# security context

variable "tenant_manage_selected_networks" {
  default = "true"
}
variable "tenant_manage_pep" {
  default = "true"
}

variable "alerts_manage" {}

variable "container_auth" {
  default = "auth"
}
variable "container_tenant" {
  default = "tenant"
}
variable "container_dim" {
  default = "dim"
}
variable "tenant_storage_fileshare" {
  default = false
}

variable "ai_manage" {
  default = false
}

# File shares for various tenant services
# See comment for the block which uses them.
variable "tenant_service_fileshares" {
  type = list(string)
  default = [
    # suffix "rockwell" stands for the subfolder this shares are mounted to
    # (C:\ProgramData\Rockwell)
    "communication-rockwell", "testcomm-rockwell", "ftlinx-rockwell"
  ]
}

