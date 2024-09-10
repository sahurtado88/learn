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

variable "acr_name" {
  type = string
}

# names of the acr-related secrets to create in harness

variable "secret_acr_username" {
  type = string
  validation {
    condition     = length(var.secret_acr_username) > 3
    error_message = "The value of secret_acr_username is too short."
  }
}

variable "secret_acr_password" {
  type = string
  validation {
    condition     = length(var.secret_acr_password) > 3
    error_message = "The value of secret_acr_password is too short."
  }
}

variable "secret_acr_server" {
  type = string
  validation {
    condition     = length(var.secret_acr_server) > 3
    error_message = "The value of secret_acr_server is too short."
  }
}
