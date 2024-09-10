variable "rg_name" {}
variable "location" {}
variable "storage_account_name" {}
variable "function_app_name" {}
variable "service_plan_name" {}
variable "application_insights_connection_string" {}
variable "application_insights_key" {}
# variable "certificate_thumbprint" {}
# variable "api_management_api_id" {}

variable "azurerm_subnet_id" {}
variable "service_plan_os_type" {
  default = "Linux"
}
variable "service_plan_sku_name" {
  default = "P1v2"
}
variable "storage_account_access_key" {
  default = ""
}
variable "connection_strings" {
  type      = list(string)
  sensitive = true
}
variable "app_settings_database" {
  default = "deployment"
}
variable "application_stack_node_version" {
  default = "18"
}
variable "https_only" {
  default = true
}
variable "always_on" {
  default = true
}
variable "remote_build" {
  default = false
}
variable "timer_clock" {
  default = "0 */5 * * * *"
}
variable "timer_clock_sync" {
  default = "0 */5 * * * *"
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

variable "memory_working_set" {
  type    = string
  default = "Alert-Average-Memory Working Set-Azure Function"
}

variable "http5" {
  type    = string
  default = "Alert-Http Server Errors-Azure Function"
}

variable "http_response_time" {
  type    = string
  default = "Alert-Http Response Time-Azure Function"
}

variable "response_queue" {
  type    = string
  default = "Alert-Request Application Queue-Azure Function"
}

variable "file_system" {
  type    = string
  default = "Alert-File System Usage-Azure Function"
}

variable "descrip_memory_working_set" {
  type    = string
  default = "The average amount of memory used by the app, in megabytes (MiB)."
}

variable "descrip_http5" {
  type    = string
  default = "The count of requests resulting in an HTTP status code = 500 but < 600."
}

variable "descrip_http_response_time" {
  type    = string
  default = "The time taken for the app to serve requests, in seconds."
}

variable "descrip_http_response_queue" {
  type    = string
  default = "The number of requests in the application request queue."
}

variable "descrip_file_system" {
  type    = string
  default = "Percentage of filesystem quota consumed by the app."
}

variable "frequency" {
  type    = string
  default = "PT5M"
}

variable "frequency_file_system" {
  type    = string
  default = "PT15M"
}

variable "window_size" {
  type    = string
  default = "PT15M"
}

variable "window_size_file_system" {
  type    = string
  default = "PT6H"
}

variable "aggregation_average" {
  type    = string
  default = "Average"
}

variable "aggregation_total" {
  type    = string
  default = "Total"
}

variable "metric_name_working_memory_set" {
  type    = string
  default = "AverageMemoryWorkingSet"
}

variable "metric_name_http5" {
  type    = string
  default = "Http5xx"
}

variable "metric_name_http_response_time" {
  type    = string
  default = "HttpResponseTime"
}

variable "metric_file_system" {
  type    = string
  default = "FileSystemUsage"
}

variable "metric_name_http_response_queue" {
  type    = string
  default = "HttpResponseTime"
}

variable "operator_generic" {
  type    = string
  default = "GreaterThan"
}

variable "threshold_2_5g" {
  type    = number
  default = 2684354560
}

variable "threshold_2g" {
  type    = number
  default = 2147483648
}

variable "threshold_1" {
  type    = number
  default = 1
}

variable "threshold_5" {
  type    = number
  default = 5
}
