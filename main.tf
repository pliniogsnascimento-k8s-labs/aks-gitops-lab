terraform {
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
  name     = "gitops-demo"
  location = "eastus"
}

module "aks" {
  source              = "Azure/aks/azurerm"
  resource_group_name = azurerm_resource_group.cluster_rg.name
  prefix              = "gitops-demo"
  agents_count        = 3
  agents_max_pods     = 100

  depends_on = [
    azurerm_resource_group.cluster_rg
  ]
}
