# variable "keyvault_object_id" {}
# variable "key_vault_name" {}

variable "key_vault_manage" {
  type        = bool
  default     = true
  description = "If it's true, will deploy the redis cache resources"
}

variable "key_vault_secret_provider_cert_permissions" {
  type = list(string)
  default = [
    "Create",
    "Delete",
    "Get",
    "Import",
    "List",
    "Update",
    "Purge",
    "Recover",
    "Restore",
  ]
}

variable "key_vault_secret_provider_key_permissions" {
  type    = list(string)
  default = []
}

variable "key_vault_secret_provider_secret_permissions" {
  type = list(string)
  default = [
    "Delete",
    "Get",
    "Set",
    "List",
    "Purge",
    "Recover",
    "Restore",
  ]
}

# variable "raider_domain_cert_name" {
#   default = "raiderdomaincert"
#   type    = string
# }
variable "raider_domain_name" {
  default = "rockwellautomation.com"
  type    = string
}
variable "raider_domain_cert_validity" {
  default = 12 # Months
  type    = number
}

variable "global_sa_constr_secret" {
  default = "global-sa-constr-secret"
  type    = string
}
variable "secret_expiry_period" {
  default = 365 # Days
  type    = number
}
