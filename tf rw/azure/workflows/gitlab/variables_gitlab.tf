# TF control vars
variable "gitlab_manage" {
  type        = bool
  default     = true
  description = "If it's true, will deploy the redis cache recourses"
}

# Postgres
# Passwords should be specified from command line during production
variable "gitlab_pg_admin_password" {
  default = ""
  type    = string
}

variable "gitlab_pg_name" {
  default = "gitlab-primary-pg"
  type    = string
}

variable "gitlab_pg_db_names" {
  default = ["gitlabhq_production", "praefect_production"]
  type    = list(any)
}

variable "gitlab_pg_ssl_enforcement_enabled" {
  default = true
  type    = bool
}

variable "gitlab_pg_ssl_minimal_tls_version_enforced" {
  # default = "TLS1_2"
  default = "TLSEnforcementDisabled"
  type    = string
}
# Redis

variable "common_redis_name" {
  default = "raredis"
  type    = string
}

variable "common_redis_enable_non_ssl" {
  default = false
  type    = bool
}

variable "common_redis_zones" {
  default = ["1", "2", "3"]
  type    = list(any)
}

# Should be equal to number of zones
variable "common_redis_replicas_per_master" {
  default = 3
  type    = number
}

variable "common_redis_sku" {
  default = "Premium"
  type    = string
}

variable "common_redis_capacity" {
  default = 1
  type    = number
}

variable "common_redis_family" {
  default = "P"
  type    = string
}

variable "errors" {
  type    = string
  default = "Alert-Errors-RedisCache"
}

variable "memory_critical" {
  type    = string
  default = "Alert-Used Memory-RedisCache"
}

variable "cpu_critical" {
  type    = string
  default = "Alert-Used CPU-RedisCache"
}

variable "descrip_errors" {
  type    = string
  default = "The number errors that occured on the cache. For more details, see https://aka.ms/redis/metrics.|ShardId, ErrorType."
}

variable "descrip_memory_critical" {
  type    = string
  default = "The amount of cache memory used for key/value pairs in the cache in MB. For more details, see https://aka.ms/redis/metrics.|ShardId|."
}

variable "descrip_cpu_critical" {
  type    = string
  default = "The CPU utilization of the Azure Redis Cache server as a percentage. For more details, see https://aka.ms/redis/metrics.|ShardId|."
}

variable "frequency" {
  type    = string
  default = "PT1M"
}

variable "window_size" {
  type    = string
  default = "PT5M"
}

variable "aggregation_maximum" {
  type    = string
  default = "Maximum"
}

variable "metric_name_errors" {
  type    = string
  default = "errors"
}

variable "metric_name_memory_used" {
  type    = string
  default = "usedmemory"
}

variable "metric_name_cpu_used" {
  type    = string
  default = "percentProcessorTime"
}

variable "operator_greater_than" {
  type    = string
  default = "GreaterThan"
}

variable "threshold_errors" {
  type    = number
  default = 3
}

variable "threshold_memory_used_critical" {
  type    = number
  default = 4294967296
}

variable "threshold_memory_used_warning" {
  type    = number
  default = 3221225472
}

variable "threshold_cpu_used_critical" {
  type    = number
  default = 90
}

variable "threshold_cpu_used_warning" {
  type    = number
  default = 80
}

