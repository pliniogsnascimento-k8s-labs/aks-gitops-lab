variable "agents_count" {
  default = 4
}

variable "max_pods" {
  default = 100
}

variable "agents_size" {
  default = "Standard_D2s_v3"
}

variable "resource_group_name" {
  default = "default_groups_name"
}

variable "location" {
  default = "Central US"
}

variable "prefix" {
  default = "default_prefix"
}
