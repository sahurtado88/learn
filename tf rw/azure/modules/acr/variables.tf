variable "rg_name" {}
variable "location" {}
variable "location_pair" {}
variable "acr_name" {}
variable "acr_public_network_enabled" {}
variable "acr_sku" {
  default = "Premium"
  type    = string
}
variable "acr_admin_enabled" {
  default = true
  type    = bool
}
variable "acr_zone_redundancy_enabled" {
  default = true
  type    = bool
}
variable "georeplications_zone_redundancy_enabled" {
  default = true
  type    = bool
}
variable "georeplications_regional_endpoint_enabled" {
  default = false
  type    = bool
}

# variable "network_rule_set_ip_range" {
#   default = ""
# }

# variable "network_rule_set_subnet_id" {
#   default = ""
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

variable "descrip_storage_used" {
  type    = string
  default = "The amount of storage used by the container registry."
}

variable "descrip_run_duratiom" {
  type    = string
  default = "Run Duration in milliseconds."
}

variable "descrip_total_pull" {
  type    = string
  default = "Number of image pulls in total."
}

variable "descrip_total_push" {
  type    = string
  default = "Number of image pushes in total."
}

variable "storage_usage" {
  type    = string
  default = "Alert-Storage Used-ACR"
}

variable "run_duration" {
  type    = string
  default = "Alert-Run Duration-ACR"
}

variable "total_pull_count" {
  type    = string
  default = "Alert-Total Pull Count-ACR"
}

variable "total_push_count" {
  type    = string
  default = "Alert-Total Push Count-ACR"
}

variable "frequency" {
  type    = string
  default = "PT5M"
}

variable "window_size" {
  type    = string
  default = "PT1H"
}

variable "window_size_generic" {
  type    = string
  default = "PT15M"
}

variable "aggregation_average" {
  type    = string
  default = "Average"
}

variable "aggregation_total" {
  type    = string
  default = "Total"
}


variable "metric_name_storage_used" {
  type    = string
  default = "StorageUsed"
}

variable "metric_name_run_duration" {
  type    = string
  default = "RunDuration"
}

variable "metric_name_total_pull_count" {
  type    = string
  default = "TotalPullCount"
}

variable "metric_name_total_push_count" {
  type    = string
  default = "TotalPushCount"
}

variable "operator" {
  type    = string
  default = "GreaterThan"
}

variable "threshold_storage_used" {
  type    = number
  default = 419430400
}

variable "threshold_25" {
  type    = number
  default = 25
}




