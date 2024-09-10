
variable "postgres_pep_manual_conn" {
  default = false
}
variable "postgres_subresource_names" {
  default = ["postgresqlServer"]
}
variable "redis_pep_manual_conn" {
  default = false
}
variable "redis_dns_zone_name" {
  default = "privatelink.redis.cache.windows.net"
}
variable "redis_subresource_names" {
  default = ["redisCache"]
}

variable "sa_gl_pep_manual_conn" {
  default = false
}
variable "sa_subresource_names" {
  default = ["blob"]
}
variable "sa_queue_subresource_names" {
  default = ["queue"]
}
variable "pep_manage" {
  default = true
}
