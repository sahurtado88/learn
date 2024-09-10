variable "sendgrid_manage" {
  type    = bool
  default = false
}

variable "sendgrid_apikey_secret" {
  type        = string
  default     = "sendgrid-apikey"
  description = "The name of the key in the KeyVault and the secrets in AKS"
}
