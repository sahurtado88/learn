variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "tenant_id" {}
variable "soft_delete_retention_days" {}
variable "sku_name" {}
variable "object_id" {}
variable "public_network_access_enabled" {
  default = false
}
variable "key_vault_manage_network_acls" {
  default = true
}
variable "key_vault_manage_selected_networks" {
  default = true
}
variable "purge_protection_enabled" {
  default = true
}
# variable "kv_vnet_subnet_ids" {
#   type    = list(string)
#   default = [""]
# }

variable "alerts_manage" {
  type    = bool
  default = false
}

variable "env_name" {
  type = string
}

variable "env_prefix" {
  type = string
}

variable "availability" {
  type    = string
  default = "Alert-Availability-Key Vault"
}

variable "shoe_box" {
  type    = string
  default = "Alert-Overall Saturation-Key Vault"
}

variable "api_hit" {
  type    = string
  default = "Alert-Service Api Hit-Key Vault"
}

variable "descrip_availability" {
  type    = string
  default = "Vault requests availability."
}

variable "descrip_shoe_box" {
  type    = string
  default = "Vault capacity used."
}

variable "descrip_api_hit" {
  type    = string
  default = "Number of total service api hits."
}

variable "frequency" {
  type    = string
  default = "PT5M"
}

variable "window_size" {
  type    = string
  default = "PT15M"
}

variable "aggregation" {
  type    = string
  default = "Average"
}

variable "metric_name_availability" {
  type    = string
  default = "Availability"
}

variable "metric_name_shoe_box" {
  type    = string
  default = "SaturationShoebox"
}

variable "metric_name_api_hit" {
  type    = string
  default = "ServiceApiHit"
}

variable "operator_less" {
  type    = string
  default = "LessThan"
}

variable "operator_generic" {
  type    = string
  default = "GreaterThan"
}

variable "threshold_availability" {
  type    = number
  default = 100
}

variable "threshold_90" {
  type    = number
  default = 90
}

variable "threshold_api_hit" {
  type    = number
  default = 500
}
