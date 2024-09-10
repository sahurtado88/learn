variable "env_name" {
  type = string
}

variable "env_prefix" {
  type = string
}

variable "secret_expiry_period" {
  default = 365 # Days
  type    = number
}

variable "sendgrid_apikey_secret" {
  type        = string
  default     = "sendgrid-apikey"
  description = "The name of the key in the KeyVault and the secrets in AKS"
}

variable "sendgrid_apikey" {
  type        = string
  sensitive   = true
  default     = ""
  description = "Sendgrid API KEY"
}
