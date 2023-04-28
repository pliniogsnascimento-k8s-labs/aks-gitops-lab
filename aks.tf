resource "azurerm_resource_group" "cluster_rg" {
  name     = var.resource_group_name
  location = var.location
}

module "aks" {
  source                    = "Azure/aks/azurerm"
  version                   = "6.5.0"
  resource_group_name       = azurerm_resource_group.cluster_rg.name
  prefix                    = var.prefix
  agents_count              = var.default_nodepool_agents_count
  agents_max_pods           = var.max_pods
  agents_availability_zones = [1, 2, 3]
  kubernetes_version        = var.kubernetes_version
  orchestrator_version      = var.kubernetes_version
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
  vm_size               = var.agents_size
  node_count            = var.microservice_nodepool_agents_count

  node_labels = {
    "scope" = "Applications"
  }

  tags = {
    Environment = "Production"
  }
}
