variable "pep_manage" {
  default = true
}
# variable "postgres_pep_name" {
#   default = "postgres-private-endpoint"
# }
# variable "redis_pep_name" {
#   default = "redis-private-endpoint"
# }
# variable "sa_gl_pep_name" {
#   default = "sa-gl-private-endpoint"
# }
# variable "postgres_pep_manual_conn" {
#   default = false
# }
# variable "postgres_subresource_names" {
#   default = ["postgresqlServer"]
# }
# variable "redis_pep_manual_conn" {
#   default = false
# }
# variable "redis_dns_zone_name" {
#   default = "privatelink.redis.cache.windows.net"
# }
# variable "redis_subresource_names" {
#   default = ["redisCache"]
# }

# variable "sa_gl_pep_manual_conn" {
#   default = false
# }
variable "sa_subresource_names" {
  default = ["blob"]
}

# ##### DELETE #####

# # variable "postgres_vnet_address" {
# #   default = ["10.245.0.0/16"]
# # }
# # variable "postgres_subnet_service_name" {
# #   default = "service-postgres"
# # }
# # variable "postgres_subnet_service_address_prefixes" {
# #   default = ["10.245.0.0/24"]
# # }
# # variable "postgres_enforce_service_network_policies" {
# #   default = false
# # }
# # variable "postgres_subnet_endpoint_name" {
# #   default = "endpoint-postgres"
# # }
# # variable "cmn_subnet_endpoint_name" {
# #   default = "endpoint-gitlab"
# # }

# # variable "cmn_subnet_endpoint_address_prefixes" {
# #   default = ["10.0.192.128/25"]
# # }
# # variable "postgres_subnet_endpoint_address_prefixes" {
# #   default = ["10.245.1.0/24"]
# # }
# # variable "postgres_enforce_endpoint_network_policies" {
# #   default = false
# # }

# # variable "postgres_pep_privserv_conn_name" {
# #   default = "postgres-privateconnection"
# # }

# # variable "postgres_dns_zone_name" {
# #   default = "privatelink.postgres.database.azure.com"
# # }
# # variable "postgres_private_conn_name" {
# #   default = "a"
# # }
# # variable "postgres_private_conn_id" {
# #   default = "1"
# # }

# # variable "postgres_pep_vnet_name" {
# #   default = "harness-postgres-vnet"
# # }
# # variable "postgres_manage_peppoint" {
# #   default = true
# # }
# # variable "postgres_make_vnet" {
# #   default = true
# # }

# # variable "postgres_pep_vnet_link_name" {
# #   default = "harness-postgres-vnet-link"
# # }

# # variable "redis_vnet_address" {
# #   default = ["10.245.0.0/16"]
# # }
# # variable "redis_subnet_service_name" {
# #   default = "service-redis"
# # }
# # variable "redis_subnet_service_address_prefixes" {
# #   default = ["10.245.0.0/24"]
# # }
# # variable "redis_enforce_service_network_policies" {
# #   default = false
# # }
# # variable "redis_subnet_endpoint_name" {
# #   default = "endpoint-redis"
# # }
# # variable "redis_subnet_endpoint_address_prefixes" {
# #   default = ["10.245.1.0/24"]
# # }
# # variable "redis_enforce_endpoint_network_policies" {
# #   default = false
# # }

# # variable "redis_pep_privserv_conn_name" {
# #   default = "redis-privateconnection"
# # }

# # variable "redis_private_conn_name" {
# #   default = "a"
# # }
# # variable "redis_private_conn_id" {
# #   default = "1"
# # }

# # variable "redis_pep_vnet_name" {
# #   default = "harness-redis-vnet"
# # }
# # variable "redis_manage_peppoint" {
# #   default = true
# # }
# # variable "redis_make_vnet" {
# #   default = true
# # }

# # variable "redis_pep_vnet_link_name" {
# #   default = "harness-redis-vnet-link"
# # }

# # variable "sa_gl_vnet_address" {
# #   default = ["10.245.0.0/16"]
# # }
# # variable "sa_gl_subnet_service_name" {
# #   default = "service-sa-gl"
# # }
# # variable "sa_gl_subnet_service_address_prefixes" {
# #   default = ["10.245.0.0/24"]
# # }
# # variable "sa_gl_enforce_service_network_policies" {
# #   default = false
# # }
# # variable "sa_gl_subnet_endpoint_name" {
# #   default = "endpoint-sa-gl"
# # }
# # variable "sa_gl_subnet_endpoint_address_prefixes" {
# #   default = ["10.245.1.0/24"]
# # }
# # variable "sa_gl_enforce_endpoint_network_policies" {
# #   default = false
# # }

# # variable "sa_gl_pep_privserv_conn_name" {
# #   default = "sa-gl-privateconnection"
# # }


# # variable "sa_gl_dns_zone_name" {
# #   default = "privatelink.azurecr.io"
# # }
# # variable "sa_gl_private_conn_name" {
# #   default = "a"
# # }
# # variable "sa_gl_private_conn_id" {
# #   default = "1"
# # }

# # variable "sa_gl_pep_vnet_name" {
# #   default = "harness-sa-gl-vnet"
# # }
# # variable "sa_gl_manage_peppoint" {
# #   default = true
# # }
# # variable "sa_gl_make_vnet" {
# #   default = true
# # }

# # variable "sa_gl_pep_vnet_link_name" {
# #   default = "harness-sa-gl-vnet-link"
# # }

