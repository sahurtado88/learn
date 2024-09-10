# # TF control vars
# variable "gitlab_manage" {
#   type        = bool
#   default     = false
#   description = "If it's true, will deploy the redis cache recourses"
# }

# # Postgres
# # Passwords should be specified from command line during production
# variable "gitlab_pg_admin_password" {
#   default = ""
#   type    = string
# }

# variable "gitlab_pg_name" {
#   default = "gitlab-primary-pg"
#   type    = string
# }

# variable "gitlab_pg_db_names" {
#   default = ["gitlabhq_production", "praefect_production"]
#   type    = list(any)
# }

# variable "gitlab_pg_ssl_enforcement_enabled" {
#   default = false
#   type    = bool
# }

# variable "gitlab_pg_ssl_minimal_tls_version_enforced" {
#   # default = "TLS1_2"
#   default = "TLSEnforcementDisabled"
#   type    = string
# }
# # Redis

# variable "common_redis_name" {
#   default = "raredis"
#   type    = string
# }

# variable "common_redis_enable_non_ssl" {
#   default = true
#   type    = bool
# }

# variable "common_redis_zones" {
#   default = ["1", "2", "3"]
#   type    = list(any)
# }

# # Should be equal to number of zones
# variable "common_redis_replicas_per_master" {
#   default = 3
#   type    = number
# }

# variable "common_redis_sku" {
#   default = "Premium"
#   type    = string
# }

# variable "common_redis_capacity" {
#   default = 1
#   type    = number
# }

# variable "common_redis_family" {
#   default = "P"
#   type    = string
# }
