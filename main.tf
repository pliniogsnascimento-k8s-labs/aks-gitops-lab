terraform {
  backend "azurerm" {}

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
      version = ">=3.0.0"
    }
  }
}
