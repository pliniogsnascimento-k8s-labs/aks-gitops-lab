resource "azurerm_resource_group" "cluster_rg" {
  name     = local.resource_group_name
  location = local.location
}

module "aks" {
  source                    = "Azure/aks/azurerm"
  version                   = "6.5.0"
  resource_group_name       = azurerm_resource_group.cluster_rg.name
  prefix                    = local.prefix
  agents_count              = local.default_nodepool_agents_count
  agents_max_pods           = local.max_pods
  agents_availability_zones = [1, 2, 3]
  kubernetes_version        = local.kubernetes_version
  orchestrator_version      = local.kubernetes_version
  # network_plugin            = "none"

  agents_labels = {
    "scope" = "ControlPlane"
  }

  depends_on = [
    azurerm_resource_group.cluster_rg
  ]
}

resource "azurerm_kubernetes_cluster_node_pool" "msnodepool" {
  name                  = "msnodepool"
  kubernetes_cluster_id = module.aks.aks_id
  vm_size               = local.agents_size
  node_count            = local.microservice_nodepool_agents_count
  priority              = "Spot"

  node_labels = {
    "scope" = "Applications"
  }

  tags = {
    Environment = "Production"
  }
}
