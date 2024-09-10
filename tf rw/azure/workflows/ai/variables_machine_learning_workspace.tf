variable "configure_ml_workspace" {
  default = false
}

variable "aml_identity_type" {
  default = "SystemAssigned"
}

variable "aml_friendly_name" {
  default = "RAIDER Machine Learning Workspace"
}

variable "aml_description" {
  default = "RAIDER Machine Learning Workspace"
}

variable "aml_high_business_impact" {
  default = true
}

variable "aml_sku_name" {
  default = "Basic"
}

variable "aml_public_network_access_enabled" {
  default = true
}
