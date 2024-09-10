# Cluster Configuration

variable "env_prefix" {
  default = "ftds"
}

variable "env_name" {
  type = string
}

variable "cluster_index" {
  type = string
}

variable "location" {
  type = string
}

# FluxCD Configuration

variable "flux_git_https_key" {
  default = "ghp_"
}

variable "flux_git_url" {
  type    = string
  default = "https://github.com/Rockwell-Automation-FTDS/fluxcd-empty"
}

variable "flux_git_reference_value" {
  type    = string
  default = "main"
}

variable "flux_namespace" {
  type    = string
  default = "flux-system"
}

# KeyVault configuration

variable "fluxcd_keyvault_key_permissions" {
  type = list(string)
  default = [
    "Get",
    "List",
    "Encrypt",
    "Decrypt"
  ]
}

variable "fluxcd_keyvault_cert_permissions" {
  type    = list(string)
  default = []
}

variable "fluxcd_keyvault_secret_permissions" {
  type    = list(string)
  default = []
}
