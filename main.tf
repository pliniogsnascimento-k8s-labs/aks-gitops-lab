terraform {
  backend "http" {}
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.4.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.1.2"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.74.0"
    }
  }
}

provider "kubernetes" {
  host                   = module.aks.host
  client_certificate     = base64decode(module.aks.client_certificate)
  client_key             = base64decode(module.aks.client_key)
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = module.aks.host
    client_certificate     = base64decode(module.aks.client_certificate)
    client_key             = base64decode(module.aks.client_key)
    cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "cluster_rg" {
  name     = var.resource_group_name
  location = var.location
}

module "aks" {
  source                    = "Azure/aks/azurerm"
  resource_group_name       = azurerm_resource_group.cluster_rg.name
  prefix                    = var.prefix
  agents_count              = var.agents_count
  agents_max_pods           = var.max_pods
  agents_availability_zones = [1, 2, 3]

  depends_on = [
    azurerm_resource_group.cluster_rg
  ]
}

resource "azurerm_kubernetes_cluster_node_pool" "microservice_node_pool" {
  name                  = "internal"
  kubernetes_cluster_id = module.aks.aks_id
  vm_size               = "Standard_DS3_v2"
  node_count            = 3

  tags = {
    Environment = "Production"
  }
}
