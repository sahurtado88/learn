variable "aks_id" {
  type = string
}

variable "aks_flux_extension_name" {
  type = string
}

variable "aks_flux_config_name" {
  type = string
}

variable "flux_config_ns" {
  type    = string
  default = "flux-system"
}

variable "flux_git_url" {
  type    = string
  default = "https://github.com/Rockwell-Automation-FTDS/fluxcd-empty"
}

variable "flux_git_reference_type" {
  type    = string
  default = "branch"
}

variable "flux_git_reference_value" {
  type    = string
  default = "main"
}

variable "flux_git_https_user" {
  type    = string
  default = "git"
}

variable "flux_git_https_key" {
  type    = string
  default = "ghp_"
}

variable "flux_kustomizations" {
  type = list(object({
    name = string
    path = string
  }))
  default = []
}
