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

variable "key_vault_racertpod_cert_permissions" {
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

variable "key_vault_racertpod_key_permissions" {
  type    = list(string)
  default = []
}

variable "key_vault_racertpod_secret_permissions" {
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

variable "fthubauth0token_name" {
  default = "fthub-auth0-token"
  type    = string
}
variable "fthubclientsecret_name" {
  default = "fthub-client-secret"
  type    = string
}
variable "fthubclientsecret_id" {
  default = "fthub-client-id"
  type    = string
}
variable "fthub_client_secret" {
  default = "{}"
  type    = string
}
variable "fthub_client_id" {
  default = "{}"
  type    = string
}
variable "ftvaultauth0token_name" {
  default = "ftvault-auth0-token"
  type    = string
}
variable "ftvaultclientsecret_name" {
  default = "ftvault-client-secret"
  type    = string
}
variable "ftvaultclientsecret_id" {
  default = "ftvault-client-id"
  type    = string
}
variable "ftvault_client_secret" {
  default = "{}"
  type    = string
}
variable "ftvault_client_id" {
  default = "{}"
  type    = string
}
variable "ftraauth0token_name" {
  default = "ftra-auth0-token"
  type    = string
}
variable "ftraclientsecret_name" {
  default = "ftra-client-secret"
  type    = string
}
variable "ftraclientsecret_id" {
  default = "ftra-client-id"
  type    = string
}
variable "ftra_client_secret" {
  default = "{}"
  type    = string
}
variable "ftra_client_id" {
  default = "{}"
  type    = string
}
variable "deployment_function_endpoint" {
  default = "deployment-function-endpoint"
  type    = string
}
variable "deployment_function_api_key" {
  default = "deployment-function-api-key"
  type    = string
}
variable "secret_expiry_period" {
  default = 365 # Days
  type    = number
}
