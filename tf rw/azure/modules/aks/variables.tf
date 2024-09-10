##### Networking ########
variable "network_rg_name" {}
########## Kubernetes Cluster ##########
variable "aks_name" {}
variable "dns_prefix" {}
########### Log Analytics #############
variable "log_analytics_workspace_id" {}
variable "container_insights_manage" {
  default = false
}
########## Default node pool ##########
variable "node_pool_name" {}
variable "node_pool_count" {}
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
variable "os_sku_win" {
  default = "Windows2022"
  type    = string
}
variable "node_pool_type" {}
variable "node_pool_availability_zone" {}
variable "node_pool_max_count" {}
variable "node_pool_min_count" {}
variable "aks_rg_name" {}
variable "aks_nrg_name" {}
variable "location" {}

# We ran into an interesting situation with tags for node pools.
# All of a sudden, the cluster-provisioning tf started failing on 2023-09-08,
# with the error message complaining about tag-based policy not allowing creation of node vmss (scaling sets).
# Here is one example:
# https://app.harness.io/#/account/1tLkbTfWTP6hX0HGc98Mww/app/QpXb-XrYSieVE5gczVycFw/pipeline-execution/mDTOB-UuS_KsAHGGCpZRbg/workflow-execution/n_SWjyC_SYa4Rzye1DW7Jg/details
#
# The details of the message got cut off, but it listed at least two tag-related policies: 
#   RA - Tags - Enforce Mandatory - VM UserManaged - OwnerEmail,
#   RA - Tags - Enforce Mandatory - VM - Environment
#   (chances are it would list them all) 
#
# We looked at the first policy in the list and discovered that it has the tag which we never set: in addition to OwnerEmail, it wants
#   ITManaged be present and not be "false"
# However, adding that tag made no difference, and also the last time that policy was modified was Dec 2022. 
# So, either Azure is not enforcing that tag for some reason, or there is a problem with the definition 
# (e.g., a missing key may be interpreted as present but having the value of "", which would be along the
# lines of gotchas in the app-gw rules - but we did not investigate).
#
# What made things work again was explicitly passing tags field in each node pool, no matter whether we defined ITManaged.
#
# That is puzzling in itself, because there are policies specifically designed to propagate the tags from resource groups
# to the resources created in them; for example,
#   RA - Tags - Append From Parent RG - All Resources - OwnerEmail
# Perhaps those policies stopped working for node pools and the tags are no longer propagated.
#
# To deal with all this, we decided to do the following:
#
#  (a) Pass tags explicitly to the node pools. Also, add the tags field to the aks resource itself, for good measure.
#  (b) Add ITManaged=true to the tags, in case the broken enforcement gets fixed in the future.
variable "tags" {
  default = {
    "ApplicationTag"     = "FTDS"
    "ApplicationName"    = "Azure Cloud Services"
    "CostCenter"         = "15567"
    "DataClassification" = "Confidential"
    "Environment"        = "Development"
    "Lifespan"           = "Months"
    "Capability"         = "Network and Cloud Services"
    "ServiceClass"       = "User Managed"
    "ProjectInitiative"  = "FTDS Preview"
    "OwnerEmail"         = "noreply@rockwellautomation.com"
    "BusinessUnit"       = "SWC - ENGINEERING SOFTWARE"
    "ITManaged"          = "true"
  }
  description = "Required tags to deploy Azure resources"
}
variable "aks_vnet_name" {}
variable "aks_subnet_name" {}
variable "aks_subnet_address_prefix" {}
variable "network_plugin" {}
variable "load_balancer_sku" {}
variable "node_pool_vm_size" {
  default = "Standard_E4as_v4"
}
variable "node_pool_vm_size_wks" {
  default = "Standard_E4as_v4"
}
variable "node_pool_vm_size_win" {
  default = "Standard_E4as_v4"
}
variable "service_cidr" {
  default = "10.240.0.0/16"
}
variable "dns_service_ip" {
  # dns_service_ip is usually the 10th ip of the service_cidr which is 10.240.0.0/16 above
  default = "10.240.0.10"
}

variable "api_server_authorized_ip_ranges" {
  type    = list(string)
  default = [""]
}
variable "max_pods" {
  default = 75
}
variable "max_pods_wks" {
  default = 50
}
variable "max_pods_win" {
  default = 50
}
variable "windows_support" {
  default = false
}
variable "win_node_pool_name" {
  default = "winnp"
}

variable "win_user_name" {
  type      = string
  default   = "azureuser"
  sensitive = true
}
variable "sku_tier" {
  default     = false
  description = "false: Free 99.9 / true: Paid 99.95 SLA"
}
variable "aks_lb_public_ip_sku" {
  default = "Standard"
}
variable "aks_lb_public_ip_allocation_method" {
  default = "Static"
}
variable "base_manage" {
  default = false
}
variable "linux_wks_node_pool_name" {
  default = "linuxnpwks"
}
variable "kubernetes_version" {
  default = "1.24"
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

variable "cpu_node" {
  type    = string
  default = "Alert-Average CPU Node-AKS"
}

variable "disk_usage" {
  type    = string
  default = "Alert-Average Disk Usage Node-AKS"
}

variable "pod_status" {
  type    = string
  default = "Alert-POD Status Failed-AKS"
}

variable "node_status" {
  type    = string
  default = "Alert-Node Status Not Ready-AKS"
}

variable "descrip_cpu_node" {
  type    = string
  default = "Aggregated average CPU utilization measured in percentage across the cluster"
}

variable "descrip_disk_usage" {
  type    = string
  default = "Disk space used in percent by device"
}

variable "descrip_pod_status" {
  type    = string
  default = "Number of pods by phase"
}

variable "descrip_node_status" {
  type    = string
  default = "Statuses for various node conditions."
}

variable "frequency" {
  type    = string
  default = "PT5M"
}

variable "window_size" {
  type    = string
  default = "PT15M"
}

variable "aggregation" {
  type    = string
  default = "Average"
}

variable "metric_name_cpu_usage" {
  type    = string
  default = "node_cpu_usage_percentage"
}

variable "metric_name_disk_usage" {
  type    = string
  default = "node_disk_usage_percentage"
}

variable "metric_name_pod_status" {
  type    = string
  default = "kube_pod_status_phase"
}

variable "metric_name_node_status" {
  type    = string
  default = "kube_node_status_condition"
}

variable "operator_generic" {
  type    = string
  default = "GreaterThan"
}

variable "operator_greater_equal" {
  type    = string
  default = "GreaterThanOrEqual"
}

variable "threshold_generic" {
  type    = number
  default = 90
}

variable "threshold_1" {
  type    = number
  default = 1
}

variable "threshold_0" {
  type    = number
  default = 0
}

variable "dimension_name_phase" {
  type    = string
  default = "phase"
}

variable "dimension_name_status" {
  type    = string
  default = "status"
}

variable "dimension_operator_include" {
  type    = string
  default = "Include"
}

variable "dimension_operator_exclude" {
  type    = string
  default = "Exclude"
}

variable "dimension_values_running" {
  type    = string
  default = "Running"
}

variable "dimension_values_not_ready" {
  type    = string
  default = "NotReady"
}

variable "windows_test_support" {
  default = false
}
variable "win_test_node_pool_name" {
  default = "winnpt"
}
variable "node_pool_vm_size_win_test" {
  default = "Standard_D8ads_v5"
}
variable "os_disk_size_gb_win_test" {
  default = 150
  type    = number
}
variable "os_sku_win_test" {
  default = "Windows2022"
  type    = string
}
variable "max_pods_win_test" {
  default = 50
}
variable "node_pool_win_test_min_count" {
  default = 1
}
variable "node_pool_win_test_max_count" {
  default = 20
}


variable "linux_mon_node_pool_name" {
  default = "linuxnpmon"
}

variable "linux_mon_node_pool_vm_size" {
  default = "Standard_E8as_v5" # 64G
}

variable "linux_mon_node_pool_os_disk_size_gb" {
  default = 150 # does it make a difference? Standard_E8as_v5 list 1023 Gi
  type    = number
}

variable "linux_mon_node_pool_max_count" {
  default = 6
  type    = number
}

# Ran into a bad situation with PVC/PV with a single node: 
# our pools are defined in 3 availability zones. The PV gets its zone affinitity
# assigned upon the first use by the pod once the PV is created. If a pod later
# is moved to a node in the different zone, the PV cannot be attached to it, and the
# node is sitting in the Pending state forever. See the details in
# https://rockwellautomation.atlassian.net/browse/RAIDVRTSI-1421
# We are using LRS volumes. We think that using ZRS volumes would remove that restriction
# and would be the best solution. However, as of 2023-09-22, ZRS volumes are not available
# in Central US region, where we running. 
# When we allocate min of 3 nodes, we end up with a node in each zone, and the moves
# become safe. Also, k8s takes volume affinity into consideration when scheduling pods:
# https://kubernetes.io/docs/setup/best-practices/multiple-zones/#storage-access-for-zones
# Still, it does not trigger auto-scale when it needs to put a pod into the zone where its
# volume can go, which means that if the pod with the PV has to be relocated (e.g., because 
# of resource pressure) and there is no node in the zone where PV is, we may still end up in
# a pickle. Need to be monitoring for that.
# It would be good to get back to this topic once ZRS is available for us. ZRS will likely
# make things more stable and will save money because we will not have to keep at least 3 nodes.
variable "linux_mon_node_pool_min_count" {
  default = 3
  type    = number
}

variable "linux_mon_node_pool_count" {
  default = 3
  type    = number
}

variable "streams" {
  type    = list(string)
  default = ["Microsoft-InsightsMetrics", "Microsoft-KubePVInventory"]
}
