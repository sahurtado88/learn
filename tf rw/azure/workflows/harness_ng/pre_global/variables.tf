variable "env_prefix" {
  type = string
}

variable "harness_provider_account_id" {
  type = string
}

variable "harness_provider_api_key" {
  type = string
}

variable "harness_secret_manager_identifier" {
  type    = string
  default = "harnessSecretManager"
}
