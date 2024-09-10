resource "azurerm_subnet" "aks_subnet" {
  name                 = var.aks_subnet_name
  virtual_network_name = var.aks_vnet_name
  resource_group_name  = var.network_rg_name
  address_prefixes     = [var.aks_subnet_address_prefix]
  service_endpoints    = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
}
resource "azurerm_public_ip" "akslbpublicip" {
  name                = "${var.aks_name}-pip"
  location            = var.location
  resource_group_name = var.aks_rg_name
  allocation_method   = var.aks_lb_public_ip_allocation_method
  sku                 = var.aks_lb_public_ip_sku
}

resource "random_password" "win_password" {
  length  = 14
  lower   = true
  upper   = true
  numeric = true
  special = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.aks_rg_name
  dns_prefix          = var.dns_prefix
  node_resource_group = var.aks_nrg_name
  kubernetes_version  = var.kubernetes_version
  tags                = var.tags
  network_profile {
    network_plugin    = var.network_plugin
    load_balancer_sku = var.load_balancer_sku
    # outbound_type = "loadBalancer"
    # pod_cidr = var.pod_cidr # not needed as we are using Azure cni
    load_balancer_profile {
      outbound_ip_address_ids = [azurerm_public_ip.akslbpublicip.id]
    }
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
  }

  default_node_pool {
    name                = var.node_pool_name
    node_count          = var.node_pool_count
    vm_size             = var.node_pool_vm_size
    type                = var.node_pool_type
    os_disk_size_gb     = var.os_disk_size_gb
    zones               = var.node_pool_availability_zone
    max_count           = var.node_pool_max_count #3
    min_count           = var.node_pool_min_count #1
    enable_auto_scaling = true
    vnet_subnet_id      = azurerm_subnet.aks_subnet.id
    max_pods            = var.max_pods
    tags                = var.tags
    temporary_name_for_rotation = "tmpnprot"
    upgrade_settings {
      max_surge = "33%"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  azure_policy_enabled = true
  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  storage_profile {
    blob_driver_enabled = true
  }

  api_server_access_profile {
    authorized_ip_ranges = var.api_server_authorized_ip_ranges
  }

  sku_tier                          = var.sku_tier ? "Standard" : "Free"
  role_based_access_control_enabled = true

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  windows_profile {
    admin_username = var.win_user_name
    admin_password = random_password.win_password.result
    license        = "Windows_Server"
  }

  dynamic "oms_agent" {
    for_each = var.container_insights_manage ? [1] : []
    content {
      log_analytics_workspace_id      = var.log_analytics_workspace_id
      msi_auth_for_monitoring_enabled = true
    }
  }

  lifecycle {
    ignore_changes = [
      tags,
      sku_tier,
      default_node_pool[0].node_count,
      kubernetes_version,
      api_server_access_profile[0].authorized_ip_ranges,
      windows_profile[0].admin_password
    ]
  }

}

resource "azurerm_kubernetes_cluster_node_pool" "linux_wks_node_pool" {
  count                 = var.base_manage ? 1 : 0
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = var.linux_wks_node_pool_name
  node_count            = var.node_pool_count
  vm_size               = var.node_pool_vm_size_wks
  os_disk_size_gb       = var.os_disk_size_gb_wks
  zones                 = var.node_pool_availability_zone
  max_count             = var.node_pool_max_count #3
  min_count             = var.node_pool_min_count #1
  enable_auto_scaling   = true
  vnet_subnet_id        = azurerm_subnet.aks_subnet.id
  max_pods              = var.max_pods_wks
  tags                  = var.tags
  upgrade_settings {
    max_surge = "33%"
  }

  lifecycle {
    ignore_changes = [
      tags,
      node_count,
    ]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "windows_node_pool" {
  count                 = var.windows_support ? 1 : 0
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = var.win_node_pool_name
  node_count            = var.node_pool_count
  vm_size               = var.node_pool_vm_size_win
  os_disk_size_gb       = var.os_disk_size_gb_win
  os_type               = "Windows"
  os_sku                = var.os_sku_win
  zones                 = var.node_pool_availability_zone
  max_count             = var.node_pool_max_count #3
  min_count             = var.node_pool_min_count #1
  enable_auto_scaling   = true
  vnet_subnet_id        = azurerm_subnet.aks_subnet.id
  max_pods              = var.max_pods_win #
  tags                  = var.tags
  windows_profile {
    outbound_nat_enabled = true
  }
  upgrade_settings {
    max_surge = "33%"
  }

  lifecycle {
    ignore_changes = [
      tags,
      node_count,
      os_sku
    ]
  }

}

resource "azurerm_kubernetes_cluster_node_pool" "windows_node_pool_test" {
  count                 = var.windows_test_support ? 1 : 0
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = var.win_test_node_pool_name
  node_count            = var.node_pool_count
  vm_size               = var.node_pool_vm_size_win_test
  os_disk_size_gb       = var.os_disk_size_gb_win_test
  os_type               = "Windows"
  os_sku                = var.os_sku_win_test
  zones                 = var.node_pool_availability_zone
  max_count             = var.node_pool_win_test_max_count #3
  min_count             = var.node_pool_win_test_min_count #1
  enable_auto_scaling   = true
  vnet_subnet_id        = azurerm_subnet.aks_subnet.id
  max_pods              = var.max_pods_win_test #
  tags                  = var.tags
  windows_profile {
    outbound_nat_enabled = true
  }
  upgrade_settings {
    max_surge = "33%"
  }
  lifecycle {
    ignore_changes = [
      tags,
      node_count,
      os_sku
    ]
  }

}

# node pool for linux-based monitoring tools
resource "azurerm_kubernetes_cluster_node_pool" "linux_mon_node_pool" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = var.linux_mon_node_pool_name
  node_count            = var.linux_mon_node_pool_count
  vm_size               = var.linux_mon_node_pool_vm_size
  os_disk_size_gb       = var.linux_mon_node_pool_os_disk_size_gb
  zones                 = var.node_pool_availability_zone
  max_count             = var.linux_mon_node_pool_max_count
  min_count             = var.linux_mon_node_pool_min_count
  enable_auto_scaling   = true
  vnet_subnet_id        = azurerm_subnet.aks_subnet.id
  max_pods              = var.max_pods_wks
  tags                  = var.tags
  node_taints = [
    "app-group=montools:NoSchedule"
  ]
  upgrade_settings {
    max_surge = "33%"
  }

  lifecycle {
    ignore_changes = [
      tags,
      node_count,
    ]
  }
}



#Alerts created for AKS

locals {
  alert_name_critical      = "${var.env_prefix}-${var.env_name}-Critical-Infra"
  severity_0               = "0"
  data_collection_interval = "2m"
  namespace_filtering      = "Off"
  enableContainerLogV2     = false
}

data "azurerm_monitor_action_group" "aks" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.env_prefix}-${var.env_name}-agn-alerts-AKS"
  resource_group_name = "ftds-monitoring-alerts"
}

resource "azurerm_monitor_metric_alert" "aks_cpu_node" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.cpu_node}-${var.aks_name}-${local.alert_name_critical}"
  resource_group_name = var.aks_rg_name
  scopes              = [azurerm_kubernetes_cluster.aks.id]
  description         = var.descrip_cpu_node
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation
    metric_name      = var.metric_name_cpu_usage
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    operator         = var.operator_generic
    threshold        = var.threshold_generic
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.aks[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "aks_disk_usage" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.disk_usage}-${var.aks_name}-${local.alert_name_critical}"
  resource_group_name = var.aks_rg_name
  scopes              = [azurerm_kubernetes_cluster.aks.id]
  description         = var.descrip_disk_usage
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation
    metric_name      = var.metric_name_disk_usage
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    operator         = var.operator_generic
    threshold        = var.threshold_generic
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.aks[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "aks_pod_status" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.pod_status}-${var.aks_name}-${local.alert_name_critical}"
  resource_group_name = var.aks_rg_name
  scopes              = [azurerm_kubernetes_cluster.aks.id]
  description         = var.descrip_pod_status
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation
    metric_name      = var.metric_name_pod_status
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    operator         = var.operator_greater_equal
    threshold        = var.threshold_1
    dimension {
      name     = var.dimension_name_phase
      operator = var.dimension_operator_exclude
      values   = [var.dimension_values_running]
    }
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.aks[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_metric_alert" "aks_node_status" {
  count               = var.alerts_manage ? 1 : 0
  name                = "${var.node_status}-${var.aks_name}-${local.alert_name_critical}"
  resource_group_name = var.aks_rg_name
  scopes              = [azurerm_kubernetes_cluster.aks.id]
  description         = var.descrip_node_status
  severity            = local.severity_0
  frequency           = var.frequency
  window_size         = var.window_size
  criteria {
    aggregation      = var.aggregation
    metric_name      = var.metric_name_node_status
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    operator         = var.operator_generic
    threshold        = var.threshold_0
    dimension {
      name     = var.dimension_name_status
      operator = var.dimension_operator_include
      values   = [var.dimension_values_not_ready]
    }
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.aks[0].id
    webhook_properties = {
      A = "workaround"
    }
  }
  auto_mitigate = true
  lifecycle {
    ignore_changes = [tags]
  }
}

#Data collewction rule 
resource "azurerm_monitor_data_collection_rule" "dcrule" {
  count               = var.container_insights_manage ? 1 : 0
  location            = var.location
  name                = "${var.aks_name}-dcrule"
  resource_group_name = var.aks_rg_name
  destinations {
    log_analytics {
      name                  = "ciworkspace"
      workspace_resource_id = var.log_analytics_workspace_id
    }
  }

  data_flow {
    destinations = ["ciworkspace"]
    streams      = var.streams
  }

  data_sources {
    extension {
      name           = "ContainerInsightsExtension"
      streams        = var.streams
      extension_name = "ContainerInsights"
      extension_json = jsonencode({
        "dataCollectionSettings" : {
          "interval" : local.data_collection_interval,
          "namespaceFilteringMode" : local.namespace_filtering,
          "enableContainerLogV2" : local.enableContainerLogV2,
        }
      })
    }
  }

}

resource "azurerm_monitor_data_collection_rule_association" "sules_associated" {
  count                   = var.container_insights_manage ? 1 : 0
  name                    = "ruleassociated"
  target_resource_id      = azurerm_kubernetes_cluster.aks.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.dcrule[0].id
}
