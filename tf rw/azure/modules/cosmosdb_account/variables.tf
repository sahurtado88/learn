variable "cosmosdb_account_name" {}
variable "cosmosdb_account_resource_group_name" {}
variable "cosmosdb_account_location" {
  default = "centralus"
}
variable "failover_location" {
  default = "westus2"
}
variable "backup_type" {
  default = "Continuous"
}
variable "public_network_access_enabled" {
  default = false
}
variable "analytical_storage_enabled" {
  default = false
}

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
  default = "Alert-Availability-CosmosDB"
}

variable "latency" {
  type    = string
  default = "Alert-Server Side Latency-CosmosDB"
}

variable "throughput" {
  type    = string
  default = "Alert-Normalized RU Consumption-CosmosDB"
}

variable "descrip_availability" {
  type    = string
  default = "Account requests availability at one hour, day or month granularity."
}

variable "descrip_latency" {
  type    = string
  default = "Server Side Latency."
}

variable "descrip_throughput" {
  type    = string
  default = "Normalized RU Consumption"
}

variable "frequency" {
  type    = string
  default = "PT5M"
}

variable "window_size" {
  type    = string
  default = "PT15M"
}

variable "window_size_availability" {
  type    = string
  default = "PT1H"
}

variable "aggregation" {
  type    = string
  default = "Average"
}

variable "metric_name_availability" {
  type    = string
  default = "ServiceAvailability"
}

variable "metric_name_latency" {
  type    = string
  default = "ServerSideLatency"
}

variable "metric_name_throughput" {
  type    = string
  default = "NormalizedRUConsumption"
}

variable "operator_lessthan" {
  type    = string
  default = "LessThan"
}

variable "operator_greaterthan" {
  type    = string
  default = "GreaterThan"
}

variable "threshold_availability" {
  type    = number
  default = 100
}

variable "threshold_latency" {
  type    = number
  default = 20
}

variable "threshold_throughput_critical" {
  type    = number
  default = 90
}

variable "threshold_throughput_warning" {
  type    = number
  default = 70
}
