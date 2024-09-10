variable "tenant_pep_manual_conn" {
  default = false
}

variable "tenant_dns_zone_name" {
  default = "privatelink.blob.core.windows.net"
}

variable "tenant_file_dns_zone_name" {
  default = "privatelink.file.core.windows.net"
}


variable "tenant_subresource_names" {
  default = ["blob"]
}

variable "tenant_file_subresource_names" {
  default = ["file"]
}


# variable "tenant_manage_pep" {
#   default = false
# }

variable "azure_subscription_id_internal" {}
variable "subscription_id" {}

# facilitates testing in non-prod environments, where simply setting external_access
# leads to an attempt to create a lot of other things, some of which fail because of
# externally-created dependencies.
# NOTE: if setting this to true, create a comment in PR as a reminder to set it to false
variable "force_manage_pep" {
  default = false
}
