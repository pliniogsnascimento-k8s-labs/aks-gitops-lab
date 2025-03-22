locals {
  default_nodepool_agents_count      = 5
  microservice_nodepool_agents_count = 0
  max_pods                           = 110
  agents_size                        = "Standard_D2s_v3"
  resource_group_name                = "gitops"
  location                           = "eastus"
  prefix                             = "gitops"
  kubernetes_version                 = "1.31.6"
}
