# variable "subscription_id" {
#   type = string
# }

variable "env_name" {}

variable "env_prefix" {
  default = "ftds"
}

variable "key_vault_manage" {
  type    = bool
  default = true
}
