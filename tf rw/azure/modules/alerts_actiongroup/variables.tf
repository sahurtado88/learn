variable "actiongroup_suffix" {
  type = string
}

variable "actiongroup_rg" {
  type = string
}

variable "webhook_service_uri" {
  type = string
}

variable "env_name" {
  type = string
}

variable "env_prefix" {
  type = string
}

variable "alert_subs" {
  type = bool
  default = false
}
