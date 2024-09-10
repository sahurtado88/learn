variable "pg_name" {}
variable "rg_name" {}
variable "location" {}
variable "pg_db_names" {}
variable "pg_admin_password" {}
variable "delegated_subnet_id" {}
variable "private_dns_zone_id" {}
variable "pg_sku" {
  default = "GP_Standard_D16ds_v4"
  type    = string
}
variable "pg_admin_username" {
  default = "localadmin"
  type    = string
}
variable "pg_version" {
  default = 14
  type    = number
}
variable "pg_charset" {
  default = "utf8"
  type    = string
}
variable "pg_collation" {
  ## default = "English_United States.1252"
  default = "en_US.utf8"
  type    = string
}
variable "pg_storage" {
  default = 131072
  type    = number
}
variable "pg_backup_retention_days" {
  default = 30
  type    = number
}
variable "pg_geo_redundant" {
  default = true
  type    = bool
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

variable "connection_failed" {
  type    = string
  default = "Alert-Failed Connections-PostgreSQL"
}

variable "cpu_percent" {
  type    = string
  default = "Alert-CPU Percent-PostgreSQL"
}

variable "memory_percent" {
  type    = string
  default = "Alert-Memory Percent-PostgreSQL"
}

variable "storage_percent" {
  type    = string
  default = "Alert-Storage Percent-PostgreSQL"
}

variable "descrip_connection_failed" {
  type    = string
  default = "Failed connections."
}

variable "descrip_cpu_percent" {
  type    = string
  default = "CPU percent."
}

variable "descrip_memory_percent" {
  type    = string
  default = "Memory percent."
}

variable "descrip_storage_percent" {
  type    = string
  default = "Storage percent."
}

variable "frequency" {
  type    = string
  default = "PT5M"
}

variable "window_size" {
  type    = string
  default = "PT15M"
}

variable "aggregation_total" {
  type    = string
  default = "Total"
}

variable "aggregation_average" {
  type    = string
  default = "Average"
}

variable "metric_name_connection_failed" {
  type    = string
  default = "connections_failed"
}

variable "metric_name_cpu_percent" {
  type    = string
  default = "cpu_percent"
}

variable "metric_name_memory_percent" {
  type    = string
  default = "memory_percent"
}

variable "metric_name_storage_percent" {
  type    = string
  default = "storage_percent"
}

variable "operator" {
  type    = string
  default = "GreaterThan"
}

variable "threshold_10" {
  type    = number
  default = 10
}

variable "threshold_90" {
  type    = number
  default = 90
}

variable "threshold_80" {
  type    = number
  default = 80
}

variable "category" {
  type    = string
  default = "Administrative"
}

variable "operation_name_firewall_rule" {
  type    = string
  default = "Microsoft.Sql/servers/firewallRules/write"
}
