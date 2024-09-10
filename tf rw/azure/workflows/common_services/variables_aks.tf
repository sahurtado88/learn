variable "azure_subscription_id_global" {}

########## Kubernetes Cluster ##########
variable "dns_prefix" {
  default = "dns"
  type    = string
}
########## Default node pool ##########
variable "node_pool_name" {
  default = "nodepool1"
  type    = string
}
variable "node_pool_vm_size" {
  default = "Standard_E4as_v4"
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
variable "node_pool_availability_zone" {
  default = ["1", "2", "3"]
  type    = list(string)
}
variable "node_pool_max_count" {
  default = 20
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
variable "windows_support" {
  default = false
}
variable "win_node_pool_name" {
  default = "winnp"
}
variable "container_insights_manage" {
  default = false
}
variable "aks_sku_tier" {
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
#     "ProjectInitiative"  = "FactoryTalk Design Studio"
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

variable "log_analytics_manage" {
  default = true
}
variable "kubernetes_version" {
  default = "1.24"
}
