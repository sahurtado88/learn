variable "azure_subscription_id_global" {}

########## Kubernetes Cluster ##########
variable "dns_prefix" {
  default = "dns"
  type    = string
}
########## Default node pool ##########
variable "node_pool_name" {
  default = "linuxnp"
  type    = string
}
variable "node_pool_vm_size" {
  default = "Standard_E4as_v4"
  type    = string
}
variable "node_pool_vm_size_wks" {
  default = "Standard_E4as_v4"
  type    = string
}
variable "node_pool_vm_size_win" {
  default = "Standard_E4as_v4"
  type    = string
}
variable "node_pool_vm_size_win_test" {
  default = "Standard_D8ads_v5"
  type    = string
}
variable "node_pool_count" {
  default = 3
  type    = number
}
variable "os_disk_size_gb" {
  default = 64
  type    = number
}
variable "os_disk_size_gb_wks" {
  default = 64
  type    = number
}
variable "os_disk_size_gb_win" {
  default = 150
  type    = number
}
variable "os_disk_size_gb_win_test" {
  default = 150
  type    = number
}
variable "os_sku_win" {
  default = "Windows2022"
  type    = string
}
variable "os_sku_win_test" {
  default = "Windows2022"
  type    = string
}
variable "node_pool_availability_zone" {
  default = ["1", "2", "3"]
  type    = list(string)
}
variable "node_pool_max_count" {
  default = 3
  type    = number
}
variable "node_pool_min_count" {
  default = 1
  type    = number
}
variable "node_pool_type" {
  default = "VirtualMachineScaleSets"
  type    = string
}
variable "node_pool_max_pods" {
  default = 75
}
variable "node_pool_max_pods_wks" {
  default = 50
}
variable "node_pool_max_pods_win" {
  default = 50
}
variable "node_pool_max_pods_win_test" {
  default = 50
}
variable "windows_support" {
  default = false
}
variable "win_node_pool_name" {
  default = "winnp"
}
variable "windows_test_support" {
  default = false
}
variable "win_test_node_pool_name" {
  default = "winnpt"
}
variable "container_insights_manage" {
  default = false
}
variable "base_manage" {
  default = false
}
variable "location" {}
# variable "tags" {
#   default = {
#     "ApplicationName"    = "RAIDER Cloud Services"
#     "ApplicationTag"     = "RAIDER Cloud"
#     "BusinessUnit"       = "SWC - ENGINEERING SOFTWARE"
#     "Capability"         = "Network and Cloud Services"
#     "CostCenter"         = "10272"
#     "DataClassification" = "Confidential"
#     "Environment"        = "Development"
#     "Lifespan"           = "Months"
#     "OwnerEmail"         = "noreply@rockwellautomation.com"
#     "ProjectInitiative"  = "RAIDER Cloud Deployment"
#     "ServiceClass"       = "User Managed"
#   }
# }

variable "load_balancer_sku" {
  default = "standard"
  type    = string
}
variable "network_plugin" {
  default = "azure"
  type    = string
}

###### Others ####

variable "dns_name_prefix" {
  description = ""
}

variable "log_analytics_manage" {
  default = true
}

variable "env_name" {}

variable "env_prefix" {
  default = "ftds"
}
variable "cluster_index" {
  default = "001"
}
variable "acr_name" {}
variable "env_index" {
  default = 0
}
variable "env_max_clusters" {
  default = 20
}
# security context

variable "aks_sku_tier" {
  default     = false
  description = "false: Free 99.9 / true: Paid 99.95 SLA"
}

variable "kubernetes_version" {
  default = "1.24"
}

variable "alerts_manage" {}
