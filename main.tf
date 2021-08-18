provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "cluster_rg" {
  name     = "gitops-demo"
  location = "eastus"
}

module "aks" {
  source                           = "Azure/aks/azurerm"
  resource_group_name              = azurerm_resource_group.cluster_rg.name
  prefix                           = "gitops-demo"
  agents_count                     = 3
  agents_max_pods                  = 100
}
