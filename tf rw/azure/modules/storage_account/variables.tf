variable "rg_name" {}
variable "location" {}
variable "storage_name" {}
variable "replication_type" {}
variable "storage_network_access" {
  default = "Allow"
}
variable "storage_manage_network" {
  default = true
}
variable "enable_https_traffic_only" {
  default = true
}
variable "allow_nested_items_to_be_public" {
  default = false
}
variable "min_tls_version" {
  default = "TLS1_2"
}
variable "bypass" {
  default = ["Metrics", "Logging", "AzureServices"]
}
# variable "network_rules_ip_rules" {
#   default = [""]
# }
# variable "storage_subnet_ids" {
#   default = []
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

variable "e2e_latency" {
  type    = string
  default = "Alert-Average E2E Latency-SA"
}

variable "availability" {
  type    = string
  default = "Alert-availability-SA"
}

variable "descrip_e2e_latency" {
  type    = string
  default = "The average end-to-end latency of successful requests made to a storage service or the specified API operation, in milliseconds."
}

variable "descrip_availability" {
  type    = string
  default = "The percentage of availability for the storage service or the specified API operation."
}

variable "frequency" {
  type    = string
  default = "PT5M"
}

variable "windows_size" {
  type    = string
  default = "PT15M"
}

variable "metric_name_e2e" {
  type    = string
  default = "SuccessE2ELatency"
}

variable "metric_name_availability" {
  type    = string
  default = "Availability"
}

variable "aggregation_generic" {
  type    = string
  default = "Average"
}

variable "operator_generic" {
  type    = string
  default = "GreaterThan"
}

variable "operator_less" {
  type    = string
  default = "LessThan"
}

variable "threshold_e2e" {
  type    = number
  default = 5000
}

variable "threshold_availability" {
  type    = number
  default = 100
}

