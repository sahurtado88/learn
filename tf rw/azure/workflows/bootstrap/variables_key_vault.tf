variable "key_vault_soft_delete" {
  default = 7
}
variable "key_vault_sku" {
  default = "standard"
}
variable "key_vault_manage" {
  type        = bool
  default     = true
  description = "If it's true, will deploy a key_vault"
}

#Certificates storage
# variable "storage_account" {
#   type = string
# }

# variable "storage_key" {
#   type = string
# }

# variable "certificate_container" {
#   type = string
# }

#Keyvault

variable "key_vault_manage_selected_networks" {
  default = false
}
