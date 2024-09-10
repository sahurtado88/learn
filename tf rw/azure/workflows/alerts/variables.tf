variable "env_prefix" {
  type = string
}

variable "env_name" {
  type = string
}

variable "service_uri_vault" {
  type = string
}

variable "service_uri_sa" {
  type = string
}

variable "service_uri_network" {
  type = string
}

variable "service_uri_appgw" {
  type = string
}

variable "service_uri_aks" {
  type = string
}

variable "service_uri_db" {
  type = string
}

variable "service_uri_security" {
  type = string
}


variable "alerts_manage" {
  type    = bool
  default = false
}
